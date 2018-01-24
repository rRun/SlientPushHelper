//
//  LocalPushHelper.h
//  Pods
//
//  Created by 何霞雨 on 16/10/31.
//
//

#import <Foundation/Foundation.h>


@protocol LocalPushHelperDelegate;
@interface LocalPushHelper : NSObject

//注册本地推送
-(void)registerLocalNotification:(NSInteger)alertTime Key:(NSString *)key alertTitle:(NSString *)alertTitle AlertBody:(NSString *)alertBody AlertLaunchImage:(NSString *)imageName AlertAction:(NSString *)alertAction BadgeNumber:(NSInteger)badgeNumber Sound:(NSString *)soundName;
// 取消某个本地推送通知
- (void)cancelLocalNotificationWithKey:(NSString *)key;

// 本地通知回调函数，当应用程序在前台时调用
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification;

@end

@protocol LocalPushHelperDelegate <NSObject>

-(void)didReceiveLocalNotification:(UILocalNotification *)notification;
@end
