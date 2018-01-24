//
//  LocalNotification.h
//  SlientPushHelper
//
//  Created by 何霞雨 on 2017/5/18.
//  Copyright © 2017年 何霞雨. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LocalNotification : UILocalNotification

-(LocalNotification *(^)())schedule;
-(LocalNotification *(^)())cancel;

@end
