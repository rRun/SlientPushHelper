//
//  PushRequestModel.h
//  SlientPushHelper
//
//  Created by 何霞雨 on 2017/5/19.
//   © 2017年 何霞雨. All rights reserved.
//

#import "PushBaseModel.h"

#import "PushSocketMessageType.h"

FOUNDATION_EXPORT NSString * const PUSH_PARAMS_DEVICE_ID;//请求参数-设备ID字段名

//数据请求的model
@interface PushRequestModel : PushBaseModel

@property(assign,nonatomic,readonly)PushSocketMessageType messageType;//获取消息类型
@property(copy, nonatomic)NSString *deviceId;//获取或设置设备唯一标示

//初始化对象
-(instancetype)initWithMessageType:(PushSocketMessageType)type;

@end
