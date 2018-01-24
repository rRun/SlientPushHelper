//
//  PushConnectRequestModel.h
//  SlientPushHelper
//
//  Created by 何霞雨 on 2017/5/19.
//  Copyright © 2017年 何霞雨. All rights reserved.
//

#import "PushRequestModel.h"

//设备类型值
FOUNDATION_EXPORT NSUInteger const PUSH_CURRENT_DEVICE_TYPE_VALUE;


//链接请求的model
@interface PushConnectRequestModel : PushRequestModel

@property(copy, nonatomic)NSString *deviceName;//获取或设置设备名称
@property(assign, nonatomic, readonly)NSUInteger deviceType;//获取或设置设备类型
@property(copy, nonatomic)NSString *deviceAccount;//获取或设置设备用户(tag)

@end
