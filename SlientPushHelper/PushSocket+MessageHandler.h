//
//  PushSocket+MessageHandler.h
//  SlientPushHelper
//
//  Created by 何霞雨 on 2017/5/19.
//  Copyright © 2017年 何霞雨. All rights reserved.
//

#import "PushSocket.h"

@class PushAckModel;
@class PushPublishModel;
@class PushPingResponseModel;
@interface PushSocket (MessageHandler)

//接收反馈数据处理
-(void)receiveAckHandler:(PushAckModel *)ack;

//接收心跳应答数据处理
-(void)receivePingAckHandler:(PushPingResponseModel *)pingAck;

//接收推送消息数据处理
-(void)receivePublishHandler:(PushPublishModel *)data;

@end
