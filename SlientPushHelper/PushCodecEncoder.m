//
//  PushCodecEncoder.m
//  SlientPushHelper
//
//  Created by 何霞雨 on 2017/5/18.
//  Copyright © 2017年 何霞雨. All rights reserved.
//

#import "PushCodecEncoder.h"

#import "PushConnectRequestModel.h"
#import "PushServiceData.h"
#import "PushLoginRequestModel.h"
#import "PushUnLoginRequestModel.h"
#import "PushPingRequestModel.h"
#import "PushDisconnectRequestModel.h"
#import "PushPubAckRequestModel.h"

@implementation PushCodecEncoder

#pragma mark -- 连接请求编码处理。
-(void)encodeConnectWithConfig:(PushServiceData *)config
                       handler:(PushCodecEncoderBlock)block{
    NSLog(@"开始客户端发起[connect]请求处理...");
    if(!config){
        NSLog(@"获取配置数据失败!");
        return;
    }
    //创建消息数据
    PushConnectRequestModel *model = [[PushConnectRequestModel alloc] init];
    [self buildCommonParamsWithConfig:config withModel:model];
    model.deviceAccount = config.alias;//1.设备用户帐号
    model.deviceName = config.deviceName;//2.设备名称
    //消息编码
    [self encodeWithReqModel:model withIsAck:YES handler:block];
}

#pragma mark -- 断开连接请求消息编码处理。
-(void)encodeDisconnectWithConfig:(PushServiceData *)config
                          handler:(PushCodecEncoderBlock)block{
    NSLog(@"开始客户端发起[Disconnect-request]请求处理...");
    if(!config){
        NSLog(@"获取配置数据失败!");
        return;
    }
    //创建断开连接请求消息数据
    PushDisconnectRequestModel *model = [[PushDisconnectRequestModel alloc] init];
    [self buildCommonParamsWithConfig:config withModel:model];
    //消息编码
    [self encodeWithReqModel:model withIsAck:NO handler:block];
}

#pragma mark -- 推送消息到达请求数据编码处理
-(void)encodePublishAckRequestWithConfig:(PushServiceData *)config
                               andPushId:(NSString *)pushId
                                 handler:(PushCodecEncoderBlock)block{
    NSLog(@"开始客户端发起[publish-request]请求处理...");
    if(!config){
        NSLog(@"获取配置数据失败!");
        return;
    }
    if(!pushId || !pushId.length){
        NSLog(@"推送ID不存在!");
        return;
    }
    //创建消息达到请求数据
    PushPubAckRequestModel *model = [[PushPubAckRequestModel alloc] init];
    [self buildCommonParamsWithConfig:config withModel:model];
    model.pushId = pushId;//1.推送ID
    //消息编码
    [self encodeWithReqModel:model withIsAck:YES handler:block];
}

#pragma mark -- 用户登录请求消息编码处理。
-(void)encodeSubscribeWithConfig:(PushServiceData *)config
                         handler:(PushCodecEncoderBlock)block{
    NSLog(@"开始客户端发起[Subscribe-request]请求处理...");
    if(!config){
        NSLog(@"获取配置数据失败!");
        return;
    }
    if(!config.alias || !config.alias.length){
        NSLog(@"获取设备标签(tag)不存在!");
        return;
    }
    //创建用户登录请求消息数据
    PushLoginRequestModel *model = [[PushLoginRequestModel alloc] init];
    [self buildCommonParamsWithConfig:config withModel:model];
    model.deviceAccount = config.alias;//1.设备帐号用户。
    //消息编码
    [self encodeWithReqModel:model withIsAck:YES handler:block];
}

#pragma mark -- 用户注销请求消息编码处理。
-(void)encodeUnsubscribeWithConfig:(PushServiceData *)config
                           handler:(PushCodecEncoderBlock)block{
    NSLog(@"开始客户端发起[Unsubscribe-request]请求处理...");
    if(!config){
        NSLog(@"获取配置数据失败!");
        return;
    }
    //创建用户注销请求消息数据
    PushUnLoginRequestModel *model = [[PushUnLoginRequestModel alloc] init];
    [self buildCommonParamsWithConfig:config withModel:model];
    //消息编码
    [self encodeWithReqModel:model withIsAck:YES handler:block];
}

#pragma mark -- 心跳请求数据消息编码处理
-(void)encodePingRequestWithConfig:(PushServiceData *)config
                           handler:(PushCodecEncoderBlock)block{
    NSLog(@"开始客户端发起[Ping-request]请求处理...");
    if(!config){
        NSLog(@"获取配置数据失败!");
        return;
    }
    //创建心跳请求消息数据
    PushPingRequestModel *model = [[PushPingRequestModel alloc] init];
    [self buildCommonParamsWithConfig:config withModel:model];
    //消息编码
    [self encodeWithReqModel:model withIsAck:YES handler:block];
}



#pragma mark -- 内置函数

#pragma mark -- 构建请求数据通用参数
-(void)buildCommonParamsWithConfig:(PushServiceData *)config
                         withModel:(PushRequestModel *)model{
    if(!model || !config) return;
    model.account = config.account;//1.接入帐号
    model.token = config.password;//2.接入密钥
    model.deviceId = config.deviceToken;//3.设备ID
}

#pragma mark -- 请求数据模型编码处理
-(void)encodeWithReqModel:(PushRequestModel *)model withIsAck:(BOOL)ack handler:(PushCodecEncoderBlock)block{
    if(!model || !block) return;
    PushFixedHeader *header = [PushFixedHeader headerWithType:model.messageType withIsAck:ack];
    NSData *data = [self encodeWithHeader:header andPayload:[model toSignJson]];
    if(data && data.length){
        block(data);
    }
}

@end
