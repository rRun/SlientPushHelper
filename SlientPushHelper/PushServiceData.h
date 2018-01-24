//
//  PushServiceData.h
//  SlientPushHelper
//
//  Created by 何霞雨 on 2017/5/18.
//  Copyright © 2017年 何霞雨. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "PushSocketSetting.h"

@interface PushServiceData : NSObject

@property(strong, nonatomic,readonly)NSString *url;//获取服务器地址。
@property(strong,nonatomic,readonly)NSString *account;//获取接入帐号
@property(strong,nonatomic,readonly)NSString *password;//获取接入密钥。
@property(strong,nonatomic,readonly)NSString *deviceToken;//获取设备令牌。
@property(strong,nonatomic,readonly)NSString *deviceName;//获取设备名称。
@property(strong,nonatomic,readonly)NSString *alias;//获取用户别名(应与服务端发送目标一致)。
@property(strong,nonatomic,readonly)NSMutableArray<NSString*> *tags;//获取用户标签有多个(应与服务端发送目标一致)。
@property(strong,nonatomic,readonly)PushSocketSetting *socket;//获取socket配置数据。

-(instancetype)init:(NSString *)url andAccount:(NSString *)account andPassword:(NSString *)pwd;

-(void)updateToken:(NSData *)token;
-(void)updateAlias:(NSString *)alias;


@end
