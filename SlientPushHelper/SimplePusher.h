//
//  SimplePusher.h
//  SlientPushHelper
//
//  Created by 何霞雨 on 2017/5/17.
//  Copyright © 2017年 何霞雨. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SimplePusher : NSObject

#pragma mark -属性
@property (nonatomic,assign,readonly)BOOL hasSocket;//是否开启长链接通知

#pragma mark - 设置初始值
@property (nonatomic,copy,readonly)SimplePusher* (^setHost)(NSString *host);//设置服务地址的接口
@property (nonatomic,copy,readonly)SimplePusher* (^setAccount)(NSString *account);//设置服务地址的账号
@property (nonatomic,copy,readonly)SimplePusher* (^setPassword)(NSString *password);//设置服务地址的密码
@property (nonatomic,copy,readonly)SimplePusher* (^setToken)(NSString *token,void (^preBlock)(NSString * token));//设置apns的token

#pragma mark - Public方法
//接收APNs远程推送消息,在appdelegate回调中调用
-(SimplePusher* (^)(NSDictionary *userInfo,NSString *modeName))receiveRemoteNotification;
//开始服务
-(SimplePusher* (^)(NSDictionary *launchOptions,BOOL hasSockect))start;

//单例
+(instancetype)defaultPusher;


@end
