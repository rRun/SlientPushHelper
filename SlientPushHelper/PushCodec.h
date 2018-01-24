//
//  PushCodec.h
//  SlientPushHelper
//
//  Created by 何霞雨 on 2017/5/18.
//  Copyright © 2017年 何霞雨. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "PushSocketMessageType.h"

@class PushFixedHeader;
@interface PushCodec : NSObject

-(PushFixedHeader *)decodeHeaderWithData:(NSData *)data withOutIndex:(NSUInteger *)index;
-(NSData *)encodeWithHeader:(PushFixedHeader *)header andPayload:(NSString *)json;

@end


/**
 * socket消息Qos枚举。
 **/
typedef NS_ENUM(NSInteger,PushSocketMessageQos){
    PushSocketMessageQosNone = 0,//无应答
    PushSocketMessageQosNot = 1,//不处置
    PushSocketMessageQosAck = 2//必须应答
};


/**
 *  固定消息头部。
 **/
@interface PushFixedHeader : NSObject

@property(assign, nonatomic, readonly)PushSocketMessageType type;//消息类型
@property(assign, nonatomic, readonly)BOOL isDup;//重复标示
@property(assign, nonatomic, readonly)BOOL isRetain;//保持标示
@property(assign, nonatomic, readonly)PushSocketMessageQos qos;//传输质量类型
@property(assign, nonatomic, readwrite)NSUInteger remainingLength;//有效消息体长度

/**
 * @brief 初始化实例。
 * @param type 消息类型。
 * @param ack 是否必须应答。
 * @param length 消息体长度。
 * @return 实例对象。
 **/
-(instancetype)initWithType:(PushSocketMessageType)type withIsAck:(BOOL)ack withRemainingLength:(NSUInteger)length;

/**
 *  初始化实例。
 * @param type 消息类型。
 * @param ack 是否必须应答。
 * @return 实例对象。
 **/
-(instancetype)initWithType:(PushSocketMessageType)type withIsAck:(BOOL)ack;

/**
 * @brief 静态初始化。
 * @param type 消息类型。
 * @param ack 是否必须应答。
 * @return 实例对象。
 **/
+(instancetype)headerWithType:(PushSocketMessageType)type withIsAck:(BOOL)ack;

@end
