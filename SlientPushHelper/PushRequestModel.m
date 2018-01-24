//
//  PushRequestModel.m
//  SlientPushHelper
//
//  Created by 何霞雨 on 2017/5/19.
//  Copyright © 2017年 何霞雨. All rights reserved.
//

#import "PushRequestModel.h"

NSString * const PUSH_PARAMS_DEVICE_ID = @"deviceId";

@implementation PushRequestModel

//初始化对象
-(instancetype)initWithMessageType:(PushSocketMessageType)type{
    if(self = [super init]){
        _messageType = type;
    }
    return self;
}

@end
