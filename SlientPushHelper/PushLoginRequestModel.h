//
//  PushLoginRequestModel.h
//  SlientPushHelper
//
//  Created by 何霞雨 on 2017/5/19.
//  Copyright © 2017年 何霞雨. All rights reserved.
//

#import "PushRequestModel.h"

@interface PushLoginRequestModel : PushRequestModel

@property(copy, nonatomic)NSString *deviceAccount;//获取或设置设备用户名(tag)

@end
