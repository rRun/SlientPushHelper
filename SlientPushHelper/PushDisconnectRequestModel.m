//
//  PushDisconnectRequestModel.m
//  SlientPushHelper
//
//  Created by 何霞雨 on 2017/5/19.
//  Copyright © 2017年 何霞雨. All rights reserved.
//

#import "PushDisconnectRequestModel.h"

@implementation PushDisconnectRequestModel

#pragma mark -- 初始化。
-(instancetype)init{
    return [super initWithMessageType:PushSocketMessageTypeDisconnect];
}

#pragma mark -- 参数签名
-(NSDictionary *)toSign{
    _params = @{PUSH_PARAMS_ACCOUNT : (self.account ? self.account : @""),
                PUSH_PARAMS_DEVICE_ID : (self.deviceId ? self.deviceId : @"")};
    
    return [super toSign];
}

@end
