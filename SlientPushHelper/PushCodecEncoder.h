//
//  PushCodecEncoder.h
//  SlientPushHelper
//
//  Created by 何霞雨 on 2017/5/18.
//  Copyright © 2017年 何霞雨. All rights reserved.
//

#import "PushCodec.h"

//编码结果处理block
typedef void (^PushCodecEncoderBlock)(NSData *);

@class PushServiceData;
@interface PushCodecEncoder : PushCodec

/**
 * @brief 连接请求编码处理。
 * @param config 配置数据。
 * @param block 编码处理block。
 **/
-(void)encodeConnectWithConfig:(PushServiceData *)config
                       handler:(PushCodecEncoderBlock)block;

/**
 * @brief 断开连接请求消息编码处理。
 * @param config 配置数据。
 * @param block 编码处理block。
 **/
-(void)encodeDisconnectWithConfig:(PushServiceData *)config
                          handler:(PushCodecEncoderBlock)block;

/**
 * @brief 用户登录请求消息编码处理。
 * @param config 配置数据。
 * @param block 编码处理block。
 **/
-(void)encodeSubscribeWithConfig:(PushServiceData *)config
                         handler:(PushCodecEncoderBlock)block;

/**
 * @brief 用户注销请求消息编码处理。
 * @param config 配置数据。
 * @param block 编码处理block。
 **/
-(void)encodeUnsubscribeWithConfig:(PushServiceData *)config
                           handler:(PushCodecEncoderBlock)block;

/**
 * @brief 推送消息到达请求编码处理。
 * @param config 配置数据。
 * @param pushId 推送ID。
 * @param block 编码处理block.
 **/
-(void)encodePublishAckRequestWithConfig:(PushServiceData *)config
                               andPushId:(NSString *)pushId
                                 handler:(PushCodecEncoderBlock)block;

/**
 * @brief 心跳请求消息编码处理。
 * @param config 配置数据。
 * @param block 编码处理block。
 **/
-(void)encodePingRequestWithConfig:(PushServiceData *)config
                           handler:(PushCodecEncoderBlock)block;



@end
