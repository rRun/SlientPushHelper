//
//  PushServiceData.m
//  SlientPushHelper
//
//  Created by 何霞雨 on 2017/5/18.
//  Copyright © 2017年 何霞雨. All rights reserved.
//

#import "PushServiceData.h"

#import "NSString+SimplePusher.h"

@implementation PushServiceData
@synthesize tags;
-(instancetype)init:(NSString *)url andAccount:(NSString *)account andPassword:(NSString *)pwd {
    self = [super init];
    if (self) {
        //1.服务器地址URL
        _url = url ? [url trim] : @"";
        //2.接入帐号
        _account = account ? [account trim] : @"";
        //3.接入密码
        _password = pwd ? [pwd trim] : @"";

    }
    return self;
}

-(void)updateToken:(NSData *)token{
    //设备令牌
    if(token && token.length){
        _deviceToken = [NSString dataToHex:token];
    }else{
        _deviceToken = nil;
    }
}
-(void)updateAlias:(NSString *)alias{
    //设备令牌
    if(alias && alias.length){
        _alias = alias;
    }else{
        _deviceToken = nil;
    }
}

-(NSMutableArray<NSString *> *)tags{
    if (!tags) {
        tags = [NSMutableArray new];
    }
    return tags;
}
@end
