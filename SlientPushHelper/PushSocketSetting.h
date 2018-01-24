//
//  PushSocketSetting.h
//  SlientPushHelper
//
//  Created by 何霞雨 on 2017/5/18.
//  Copyright © 2017年 何霞雨. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PushSocketSetting : NSObject

@property(strong, nonatomic, readonly)NSString *server;//获取socket服务器地址
@property(assign, nonatomic, readonly)NSUInteger port;//获取socket服务器端口
@property(assign, nonatomic, readwrite)NSUInteger rate;//获取socket心跳间隔值(秒
@property(assign, nonatomic, readonly)NSUInteger times;//获取socket心跳丢失次数
@property(assign, nonatomic, readwrite)NSUInteger reconnect;//获取socket重连时间(秒)

/**
 * @brief 初始化数据。
 * @param dict 字典数据。
 **/
-(void)initialConfigWithDict:(NSDictionary *)dict;

@end
