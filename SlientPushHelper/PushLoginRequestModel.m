//
//  PushLoginRequestModel.m
//  SlientPushHelper
//
//  Created by 何霞雨 on 2017/5/19.
//  Copyright © 2017年 何霞雨. All rights reserved.
//

#import "PushLoginRequestModel.h"

static NSString * const PUSH_PARAMS_DEVICE_ACCOUNT = @"deviceAccount";
@implementation PushLoginRequestModel

-(instancetype)init{
    return [super initWithMessageType:PushSocketMessageTypeSubscribe];
}


-(NSDictionary *)toSign{
    _params = @{ PUSH_PARAMS_ACCOUNT : (self.account ? self.account : @""),
                 PUSH_PARAMS_DEVICE_ID : (self.deviceId ? self.deviceId : @""),
                 PUSH_PARAMS_DEVICE_ACCOUNT : (_deviceAccount ? _deviceAccount : @"")
                 };
    return [super toSign];
}

@end
