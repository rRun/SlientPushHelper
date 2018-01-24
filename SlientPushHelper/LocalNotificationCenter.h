//
//  LocalNotificationCenter.h
//  SlientPushHelper
//
//  Created by 何霞雨 on 2017/5/18.
//  Copyright © 2017年 何霞雨. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LocalNotification;
@interface LocalNotificationCenter : NSObject

@property (nonatomic,copy,readonly)LocalNotificationCenter* (^bindSuccessRegisterBlock)();//绑定注册成功回调
@property (nonatomic,copy,readonly)LocalNotificationCenter* (^bindFailRegisterBlock)(NSError * _Nullable error);//绑定注册失败回调

+(LocalNotificationCenter *)sharedCenter;
-(LocalNotificationCenter *(^)())cancelAll;


@end
