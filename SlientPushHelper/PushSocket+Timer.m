//
//  PushSocket+Timer.m
//  SlientPushHelper
//
//  Created by 何霞雨 on 2017/5/18.
//  Copyright © 2017年 何霞雨. All rights reserved.
//

#import "PushSocket+Timer.h"

//重连队列
#define PUSH_DISPATCH_QUEUE_RECONNECT_NAME "com.cdfortis.push.reconnect"
//重启队列
#define PUSH_DISPATCH_QUEUE_RESTART_NAME "com.cdfortis.push.restart"
//心跳队列
#define PUSH_DISPATCH_QUEUE_PING_NAME "com.cdfortis.push.ping"

@implementation PushSocket (Timer)

//自动重连处理
-(void)reconnectHandler{
    
    __weak typeof(self) weakSelf = self;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //重连队列
        dispatch_queue_t queue = dispatch_queue_create(PUSH_DISPATCH_QUEUE_RECONNECT_NAME, DISPATCH_QUEUE_SERIAL);
        dispatch_async(queue, ^{
            @try {
                __strong typeof(weakSelf) strongSelf = weakSelf;
                //计数器,间隔时间
                NSUInteger totals = 0, interval = 5;
                //检查连接状态
                while(strongSelf && strongSelf.isStart && !strongSelf.isRun && (totals < NSIntegerMax)){
                    totals++;//计数器递增
                    dispatch_async(dispatch_get_main_queue(), ^{
                        @try {
                            __strong typeof(weakSelf) strongSelfMain = weakSelf;
                            if(!strongSelfMain.delegate) return;
                            //调用重连处理
                            if([strongSelfMain.delegate respondsToSelector:@selector(pushSocket:withStartReconnect:)]){
                                [strongSelfMain.delegate pushSocket:self withStartReconnect:YES];
                            }
                        } @catch (NSException *exception) {
                            NSLog(@"reconnectHandler-reconnect-exception:%@", exception);
                        }
                    });
                    //线程等待,每次增加
                    sleep(interval * (totals + 1) * 1.5);
                }
            } @catch (NSException *exception) {
                NSLog(@"reconnectHandler-发送异常:%@", exception);
            } @finally {
                onceToken = 0;//释放单例
            }
        });
        
    });
}

//重启连接处理(按协议延时重连)
#pragma mark -- 重启连接处理
-(void)restartHandler{
    //单例方法
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //获取配置
        PushSocketSetting *conf = self.getConfig ? self.getConfig.socket : nil;
        if(!conf || !conf.reconnect){
            onceToken = 0;
            NSLog(@"restartConnectHandler-获取重连间隔时间失败!");
            return;
        }
        //重连次数
        NSUInteger reconnectSleep = conf.reconnect, reconnectMaxTotals = conf.times;
        if(!reconnectSleep || !reconnectMaxTotals){
            onceToken = 0;
            NSLog(@"restartConnectHandler(reconnect:%zd,times:%zd)-参数错误!", reconnectSleep, reconnectMaxTotals);
            return;
        }
        __weak typeof(self) weakSelf = self;
        //重启队列
        dispatch_queue_t queue = dispatch_queue_create(PUSH_DISPATCH_QUEUE_RESTART_NAME, DISPATCH_QUEUE_CONCURRENT);
        //启动异步线程
        dispatch_async(queue, ^{
            //启动执行次数
            dispatch_apply(reconnectMaxTotals, queue, ^(size_t index) {
                __strong typeof(weakSelf) strongSelf = weakSelf;
                if(strongSelf.isRun){
                    NSLog(@"restartConnectHandler-(start:%zd,run:%zd)!", strongSelf.isStart, strongSelf.isRun);
                    onceToken = 0;
                    return;
                }
                //线程延迟执行
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(reconnectSleep * NSEC_PER_SEC)), queue, ^{
                    NSLog(@"restartConnectHandler-重连次数(%ld)=>(start:%zd,run:%zd)", (index + 1), strongSelf.isStart, strongSelf.isRun);
                    //检查主线程是否已结束
                    if(!strongSelf.isStart || strongSelf.isRun){
                        onceToken = 0;
                        return;
                    }
                    //返回主线程处理执行重连
                    dispatch_async(dispatch_get_main_queue(), ^{
                        __strong typeof(weakSelf) strongSelfMain = weakSelf;
                        if(!strongSelfMain.delegate) return;
                        //调用重连处理
                        if([strongSelfMain.delegate respondsToSelector:@selector(pushSocket:withStartReconnect:)]){
                            [strongSelfMain.delegate pushSocket:self withStartReconnect:YES];
                        }
                    });
                });
            });
            //等候全部执行完成
            dispatch_barrier_async(queue, ^{
                onceToken = 0;
                NSLog(@"restartConnectHandler-执行完成!");
            });
        });
    });
}

//开启心跳处理
-(void)startPingHandler{
    //单例方法
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //获取配置
        PushSocketSetting *conf = self.getConfig ? self.getConfig.socket : nil;
        if(!conf || !conf.rate){
            onceToken = 0;
            NSLog(@"获取心跳间隔时间失败!");
            return;
        }
        __weak typeof(self) weakSelf = self;
        NSUInteger rate = conf.rate;
        //心跳队列
        dispatch_queue_t queue = dispatch_queue_create(PUSH_DISPATCH_QUEUE_PING_NAME, DISPATCH_QUEUE_SERIAL);
        //gcd定时器
        dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
        //设置时间间隔
        dispatch_source_set_timer(timer, dispatch_time(DISPATCH_TIME_NOW, rate * NSEC_PER_SEC), rate * NSEC_PER_SEC, 0);
        //业务处理
        dispatch_source_set_event_handler(timer, ^{
            __strong typeof(weakSelf) strongSelf = weakSelf;
            //判断是否已停止
            if(!strongSelf.isStart || !strongSelf.isRun){
                dispatch_source_cancel(timer);//停止心跳线程
                onceToken = 0;
                NSLog(@"startPingHandler-socket已停止服务,心跳定时线程停止!");
                return;
            }
            //判断是否需要心跳处理
            NSTimeInterval current = [NSDate date].timeIntervalSince1970;
            if(current - strongSelf.lastPingTime < rate){
                NSLog(@"startPingHandler-no ping!");
                return;
            }
            //线程等候2秒
            sleep(2);
            //执行心跳处理
            dispatch_async(dispatch_get_main_queue(), ^{
                __strong typeof(weakSelf) strongSelfMain = weakSelf;
                NSLog(@"startPingHandler-socket-发送心跳请求...");
                if(!strongSelfMain.getEncoder) return;
                [strongSelfMain.getEncoder encodePingRequestWithConfig:strongSelfMain.getConfig handler:^(NSData *buf) {
                    [strongSelfMain sendRequestWithData:buf];
                }];
            });
            //判断心跳时间是否被重置
            if(rate != conf.rate){
                NSLog(@"startPingHandler-心跳被重置(%zd=>%zd)...", rate, conf.rate);
                //停止心跳线程
                dispatch_source_cancel(timer);
                onceToken = 0;
                //主线程重启心跳调用
                dispatch_async(dispatch_get_main_queue(), ^{
                    __strong typeof(weakSelf) strongSelfMainPing = weakSelf;
                    //重启心跳
                    [strongSelfMainPing startPingHandler];
                });
            }
        });
        //启动定时器。
        dispatch_resume(timer);
    });
}
@end
