//
//  SimplePusher.m
//  SlientPushHelper
//
//  Created by 何霞雨 on 2017/5/17.
//  Copyright © 2017年 何霞雨. All rights reserved.
//

#import "SimplePusher.h"
#import <UIKit/UIApplication.h>

#import "PushBaseModel.h"

#import "PushServiceData.h"

NSString * const PUSH_SRV_URL_PREFIX      = @"http";


@implementation SimplePusher
{
    @protected __block NSString * _host;
    @protected __block NSString * _account;
    @protected __block NSString * _password;
    @protected __block NSString * _token;
    
    @protected __block NSString * _modelName;
    
    
    PushServiceData *_accessData;
}

#pragma mark -- 单例
+(instancetype)defaultPusher{
    static SimplePusher *_instance;
    //
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[SimplePusher alloc] init];
    });
    return _instance;
}

#pragma mark -- 初始化。
-(instancetype)init{
    if(self = [super init]){

    }
    return self;
}

-(SimplePusher* (^)(NSDictionary *,BOOL))start{
    return ^(NSDictionary *launchOptions,BOOL hasSockect){
        //检查接入帐号
        if(!_account || !_account.length) @throw [NSException exceptionWithName:@"account" reason:@"接入帐号(account)不能为空!" userInfo:nil];
        //检查接入密码
        if(!_password || !_password.length) @throw [NSException exceptionWithName:@"pwd" reason:@"接入密钥(password)不能为空!" userInfo:nil];
        //检查设备令牌
        if(!_token || !_token.length) @throw [NSException exceptionWithName:@"token" reason:@"设备令牌(token)不能为空!" userInfo:nil];
        
        if (hasSockect) {
            //初始化数据
             _accessData = [[PushServiceData alloc]init:_host andAccount:_account andPassword:_password];
            //访问HTTP服务器
            // [self accessHttpServer];
        }
        
        NSDictionary * userInfo = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
        if(userInfo)
            self.receiveRemoteNotification(userInfo, _modelName);
        return self;
    };
}

#pragma mark -- 接收远程推送消息。
-(SimplePusher* (^)(NSDictionary *,NSString *))receiveRemoteNotification{
    return ^(NSDictionary *userInfo,NSString *modeName){
        if(!userInfo || !userInfo.count) return self;
        if(!modeName) return self;
        Class PushModel = NSClassFromString(modeName);
        
        id model;
        if ([PushModel isSubclassOfClass:[PushBaseModel class]]) {//解析远程通知
             //model = [[PushModel alloc]initWithInfo:userInfo];
        }
       
        if(!model){
            NSLog(@"receiveRemoteNotification-消息解析错误!=>%@", userInfo);
            return self;
        }
        //推送到App前台
        [self pushwithPublish:model withIsApns:YES];
        
        return self;
    };
}

#pragma mark -- 推出推送消息
-(void)pushwithPublish:(PushBaseModel *)publish withIsApns:(BOOL)isApns{
    if(!publish)return;


}

#pragma mark - Getter
-(SimplePusher* (^)(NSString *))setHost{
    return ^(NSString * hostUrl){
        if(!hostUrl || !hostUrl.length){
            @throw [NSException exceptionWithName:@"host" reason:@"服务器(host)不能为空!" userInfo:nil];
        }
        
        //
        NSMutableString *url = [NSMutableString string];
        //检查前部
        if(![hostUrl hasPrefix:PUSH_SRV_URL_PREFIX]){
            @throw [NSException exceptionWithName:@"host" reason:@"服务器(host)格式错误!" userInfo:nil];
        }
        
        NSLog(@"url:%@", url);
        _host = hostUrl;
        return self;
    };
}
-(SimplePusher* (^)(NSString *))setAccount{
    return ^(NSString * account){
        if(!account || !account.length){
            @throw [NSException exceptionWithName:@"account" reason:@"服务器(account)不能为空!" userInfo:nil];
        }
        NSLog(@"account:%@", account);
        _account = account;
        return self;
    };
}
-(SimplePusher* (^)(NSString *))setPassword{
    return ^(NSString * password){
        if(!password || !password.length){
            @throw [NSException exceptionWithName:@"password" reason:@"服务器(password)不能为空!" userInfo:nil];
        }
        NSLog(@"password:%@", password);
        _password = password;
        return self;
    };
}
-(SimplePusher* (^)(NSString *,void (^preBlock)(NSString * token)))setToken{
    return ^(NSString * token,void (^preBlock)(NSString * token)){
        if(!token || !token.length){
            @throw [NSException exceptionWithName:@"token" reason:@"服务器(token)不能为空!" userInfo:nil];
        }
        NSLog(@"password:%@", token);
        _token = token;
        preBlock(token);
        return self;
    };
}

-(void)test{
    [SimplePusher defaultPusher].start(nil, NO);
}
@end
