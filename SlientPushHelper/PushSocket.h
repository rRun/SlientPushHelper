//
//  PushSocket.h
//  SlientPushHelper
//
//  Created by 何霞雨 on 2017/5/18.
//  Copyright © 2017年 何霞雨. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "PushServiceData.h"
#import "PushSocketMessageType.h"

#import "PushCodecDecoder.h"
#import "PushCodecEncoder.h"

@class PushSocket;
@class PushPublishModel;

//推送socket处理委托
@protocol PushSocketHandlerDelegate <NSObject>

//启动重连,reconnect是否重连
-(void)pushSocket:(PushSocket *)socket withStartReconnect:(BOOL)reconnect;
//加载Socket配置数据
-(void)pushSocket:(PushSocket *)socket withAccessConfig:(PushServiceData **)config;
//socket异常处理
-(void)pushSocket:(PushSocket *)socket withMessageType:(PushSocketMessageType)type throwsError:(NSError *)error;
//推送消息
-(void)pushSocket:(PushSocket *)socket withPublish:(PushPublishModel *)publish;

@end

@class PushCodecEncoder;
@interface PushSocket : NSObject

@property(assign,atomic,readonly)BOOL isRun;//是否在运行中
@property(assign,atomic,readonly)BOOL isStart;//获取或设置是否已启动socket
@property(assign,atomic,readonly)NSTimeInterval lastPingTime;//上次心跳时间戳

@property(retain,atomic,readonly, getter=getConfig)PushServiceData *config;//sockect配置

@property(retain,atomic,readonly, getter=getEncoder)PushCodecEncoder *encoder;//获取消息编码器
@property(retain,atomic,readonly, getter=getPushIdCache)NSMutableArray *pushIdCache;//获取推送消息ID缓存

@property(assign,nonatomic)id<PushSocketHandlerDelegate> delegate;//回调

//单例对象
+(instancetype)shareSocket;
//开始
-(void)start;
//停止
-(void)stop;
//添加或更改用户标签处理
-(void)addOrChangedTagHandler;
//清除用户标签处理
-(void)clearTagHandler;

//向服务器发送请求数据
-(void)sendRequestWithData:(NSData *)data;

//异常处理
-(void)throwsErrorWithMessageType:(PushSocketMessageType)type andMessage:(NSString *)message;
@end
