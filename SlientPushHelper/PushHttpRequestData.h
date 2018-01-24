//
//  PushHttpRequestData.h
//  SlientPushHelper
//
//  Created by 何霞雨 on 2017/5/18.
//  Copyright © 2017年 何霞雨. All rights reserved.
//

#import "PushBaseModel.h"

@class PushServiceData;
@interface PushHttpRequestData : PushBaseModel

-(instancetype)initWithAccess:(const PushServiceData *)access;

-(NSDictionary *)toSignParameters;

@end
