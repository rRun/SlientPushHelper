//
//  PushHttpRequestData.m
//  SlientPushHelper
//
//  Created by 何霞雨 on 2017/5/18.
//  Copyright © 2017年 何霞雨. All rights reserved.
//

#import "PushHttpRequestData.h"

#import "PushServiceData.h"

@implementation PushHttpRequestData

#pragma mark -- 构造函数
-(instancetype)initWithAccess:(const PushServiceData *)access{
    if(self = [super init]){
        //接入帐号
        self.account = access.account;
        //接入密钥
        self.token = access.password;
        //参数设置
        _params = @{ PUSH_PARAMS_ACCOUNT : access.account };
    }
    return self;
}

#pragma mark -- 参数签名
-(NSDictionary *)toSignParameters{
    return [self toSign];
}

@end
