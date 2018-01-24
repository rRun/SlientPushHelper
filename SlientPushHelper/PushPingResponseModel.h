//
//  PushPingResponseModel.h
//  SlientPushHelper
//
//  Created by 何霞雨 on 2017/5/19.
//  Copyright © 2017年 何霞雨. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PushPingResponseModel : NSObject
/**
 * @brief 心跳间隔改变。
 **/
@property(assign,nonatomic,readonly)NSInteger heartRate;

/**
 * @brief 断开重连间隔。
 **/
@property(assign,nonatomic,readonly)NSInteger afterConnect;

/**
 * @brief 初始化。
 * @param data 数据集。
 * @return 对象实例。
 **/
-(instancetype)initWithData:(NSDictionary *)data;

/**
 * @brief 静态构建。
 * @param json 反馈JSON字符串。
 * @return 实例对象。
 **/
+(instancetype)pingResponseWithJSON:(NSString *)json;

@end
