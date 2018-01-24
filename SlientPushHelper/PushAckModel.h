//
//  PushAckModel.h
//  SlientPushHelper
//
//  Created by 何霞雨 on 2017/5/18.
//  Copyright © 2017年 何霞雨. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PushSocketMessageType.h"

/**
 * @brief 应答数据模型状态枚举。
 **/
typedef NS_ENUM(NSInteger, PushAckModelResult){
    /**
     * @brief 成功。
     **/
    PushAckModelResultSuccess = 0,
    /**
     * @brief 接入帐号不存在。
     **/
    PushAckModelResultAccountError = -1,
    /**
     * @brief 校验码错误。
     **/
    PushAckModelResultSignError = -2,
    /**
     * @brief 参数错误。
     **/
    PushAckModelResultParamError = -3
};


@interface PushAckModel : NSObject

/**
 * @brief 获取反馈消息类型。
 **/
@property(assign, nonatomic, readonly)PushSocketMessageType type;

/**
 * @brief 获取状态枚举。
 **/
@property(assign, nonatomic, readonly)PushAckModelResult result;

/**
 * @brief 获取消息内容。
 **/
@property(copy, nonatomic, readonly)NSString *msg;

/**
 * @brief 初始化对象。
 * @param type 反馈消息类型。
 * @param ack 反馈的数据集合。
 * @return 反馈对象实例。
 **/
-(instancetype)initWithType:(PushSocketMessageType)type andAck:(NSDictionary *)ack;

/**
 * @brief 静态初始化对象。
 * @param type 反馈消息类型。
 * @param json 反馈的JSON数据。
 * @return 反馈对象实例。
 **/
+(instancetype)ackWithType:(PushSocketMessageType)type andAckJson:(NSString *)json;


@end
