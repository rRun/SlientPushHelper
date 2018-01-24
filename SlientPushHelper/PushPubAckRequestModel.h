//
//  PushPubAckRequestModel.h
//  SlientPushHelper
//
//  Created by 何霞雨 on 2017/5/19.
//  Copyright © 2017年 何霞雨. All rights reserved.
//

#import "PushRequestModel.h"

@interface PushPubAckRequestModel : PushRequestModel
@property(copy,nonatomic)NSString *pushId;//推送消息ID
@end
