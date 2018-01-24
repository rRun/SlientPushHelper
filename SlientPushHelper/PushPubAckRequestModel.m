//
//  PushPubAckRequestModel.m
//  SlientPushHelper
//
//  Created by 何霞雨 on 2017/5/19.
//  Copyright © 2017年 何霞雨. All rights reserved.
//

#import "PushPubAckRequestModel.h"

static NSString * const PUSH_PARAMS_PUSH_ID = @"pushId";

@implementation PushPubAckRequestModel

#pragma mark -- 初始化
-(instancetype)init{
    return [super initWithMessageType:PushSocketMessageTypePuback];
}

#pragma mark -- 签名
-(NSDictionary *)toSign{
    _params = @{ PUSH_PARAMS_ACCOUNT : (self.account ? self.account : @""),
                 PUSH_PARAMS_DEVICE_ID : (self.deviceId ? self.deviceId : @""),
                 PUSH_PARAMS_PUSH_ID : (_pushId ? _pushId : @"")};
    return [super toSign];
}



@end
