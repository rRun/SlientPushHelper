//
//  LocalPushHelper.m
//  Pods
//
//  Created by 何霞雨 on 16/10/31.
//
//

#import "LocalPushHelper.h"

@implementation LocalPushHelper

//推送本地通知
-(void)registerLocalNotification:(NSInteger)alertTime Key:(NSString *)key alertTitle:(NSString *)alertTitle AlertBody:(NSString *)alertBody AlertLaunchImage:(NSString *)imageName AlertAction:(NSString *)alertAction BadgeNumber:(NSInteger)badgeNumber Sound:(NSString *)soundName{
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    // 设置触发通知的时间
    NSDate *fireDate = [NSDate dateWithTimeIntervalSinceNow:alertTime];
    NSLog(@"fireDate=%@",fireDate);
    
    notification.fireDate = fireDate;
    // 时区
    notification.timeZone = [NSTimeZone defaultTimeZone];
    // 设置重复的间隔
    notification.repeatInterval = kCFCalendarUnitSecond;
    
    // 通知内容
    notification.alertBody =  alertBody;
    notification.alertAction =  alertAction;
    notification.alertLaunchImage =  imageName;
    notification.alertTitle =  alertTitle;

    notification.applicationIconBadgeNumber = badgeNumber;
    // 通知被触发时播放的声音
    if (soundName) {
        notification.soundName = soundName;

    }else{
        notification.soundName = UILocalNotificationDefaultSoundName;

    }
        // 通知参数
    NSDictionary *userDict = [NSDictionary dictionaryWithObject:key forKey:@"key"];
    notification.userInfo = userDict;
    
    // ios8后，需要添加这个注册，才能得到授权
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        UIUserNotificationType type =  UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:type
                                                                                 categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        // 通知重复提示的单位，可以是天、周、月
        notification.repeatInterval = NSCalendarUnitDay;
    } else {
        // 通知重复提示的单位，可以是天、周、月
        notification.repeatInterval = NSDayCalendarUnit;
    }
    
    // 执行通知注册
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
}

// 本地通知回调函数，当应用程序在前台时调用
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    NSLog(@"noti:%@",notification);
    
    // 这里真实需要处理交互的地方
    // 获取通知所带的数据
    NSString *notMess = [notification.userInfo objectForKey:@"key"];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"本地通知(前台)"
                                                    message:notMess
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
    
    // 更新显示的徽章个数
    NSInteger badge = [UIApplication sharedApplication].applicationIconBadgeNumber;
    badge--;
    badge = badge >= 0 ? badge : 0;
    [UIApplication sharedApplication].applicationIconBadgeNumber = badge;
    
    // 在不需要再推送时，可以取消推送
    [self cancelLocalNotificationWithKey:@"key"];
}

// 取消某个本地推送通知
- (void)cancelLocalNotificationWithKey:(NSString *)key {
    // 获取所有本地通知数组
    NSArray *localNotifications = [UIApplication sharedApplication].scheduledLocalNotifications;
    
    for (UILocalNotification *notification in localNotifications) {
        NSDictionary *userInfo = notification.userInfo;
        if (userInfo) {
            // 根据设置通知参数时指定的key来获取通知参数
            NSString *keyR = userInfo[@"key"];
            
            // 如果找到需要取消的通知，则取消
            if (keyR != nil && [key isEqualToString:keyR]) {
                [[UIApplication sharedApplication] cancelLocalNotification:notification];
                break;  
            }  
        }  
    }  
}

@end
