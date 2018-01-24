//
//  PushSocket+MessageHandler.m
//  SlientPushHelper
//
//  Created by 何霞雨 on 2017/5/19.
//  Copyright © 2017年 何霞雨. All rights reserved.
//

#import "PushSocket+MessageHandler.h"

#import "PushSocket+Timer.h"

#import "PushAckModel.h"
#import "PushPingResponseModel.h"
#import "PushPublishModel.h"

@implementation PushSocket (MessageHandler)
//接收心跳应答数据处理
-(void)receivePingAckHandler:(PushPingResponseModel *)pingAck{
    NSLog(@"socket-心跳反馈处理=>%@", pingAck);
    if(!pingAck) return;
    if(pingAck.heartRate > 0 && self.getConfig && self.getConfig.socket){
        self.getConfig.socket.rate = pingAck.heartRate;
    }
    if(pingAck.afterConnect > 0 && self.getConfig && self.getConfig.socket){
        self.getConfig.socket.reconnect = pingAck.afterConnect;
        //断开连接
        [self stop];
        //启动重启定时器
        [self restartHandler];
    }
}

//接收反馈数据处理
-(void)receiveAckHandler:(PushAckModel *)ack{
    if(ack.result == PushAckModelResultSuccess){
        NSLog(@"socket发送(%zd)请求反馈成功!", ack.type);
        if(ack.type == PushSocketMessageTypeConnack){//判断是否为连接成功应答
            NSLog(@"socket客户端准备开启心跳处理...");
            [self startPingHandler];
        }
        return;
    }
    NSLog(@"socket发送(%zd)请求失败(%zd)=>%@", ack.type, ack.result, ack.msg);
    [self stop];//停止服务
    [self throwsErrorWithMessageType:ack.type andMessage:ack.msg];
}

//接收推送消息数据处理
-(void)receivePublishHandler:(PushPublishModel *)data{
    if(!data){
        [self throwsErrorWithMessageType:PushSocketMessageTypePublish andMessage:@"推送消息解析失败!"];
        return;
    }
    if(!self.getEncoder){
        [self throwsErrorWithMessageType:PushSocketMessageTypePublish andMessage:@"获取消息编码器失败!"];
        return;
    }
    //发送推送消息到达请求消息
    __weak typeof(self) weakSelf = self;
    [self.getEncoder encodePublishAckRequestWithConfig:self.getConfig andPushId:data.pushId handler:^(NSData *buf) {
        __strong typeof(weakSelf)strongSelf = weakSelf;
        [strongSelf sendRequestWithData:buf];
    }];
    //判断消息是否已接收过
    if(self.getPushIdCache.count > 0 && [self.getPushIdCache containsObject:data.pushId]){
        NSLog(@"消息[%@]已推送过，将忽略不向App展示!", data.pushId);
        return;
    }
    //将数据保存到缓存中
    [self.getPushIdCache addObject:data.pushId];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        __strong typeof(weakSelf)strongSelf = weakSelf;
        //检查是否设置了代理
        if(!strongSelf.delegate)return;
        //检查代理是否实现了方法
        if([strongSelf.delegate respondsToSelector:@selector(pushSocket:withPublish:)]){
            [strongSelf.delegate pushSocket:self withPublish:data];
        }
    });
}
@end
