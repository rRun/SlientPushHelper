//
//  PushService.h
//  SlientPushHelper
//
//  Created by 何霞雨 on 2017/5/17.
//  Copyright © 2017年 何霞雨. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PushServiceData;
@interface PushService : NSObject

+(instancetype)sharedHttpServer;

-(void)accessHttpServer;

-(void)setServiceSetting:(PushServiceData *)data;
-(BOOL)addOrUpdateDeviceUserWithAlias:(NSString *)alias;

@end
