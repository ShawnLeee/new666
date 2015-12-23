//
//  UILocalNotification+DG.m
//  NSLocalNotification
//
//  Created by sxq on 15/10/22.
//  Copyright © 2015年 sxq. All rights reserved.
//

#import "UILocalNotification+DG.h"

@implementation UILocalNotification (DG)
+ (void)localNotificationWithBody:(NSString *)body timeIntervel:(NSTimeInterval)timeIntervel indentifier:(NSString *)identifier
{
    UILocalNotification *localNotification = [UILocalNotification new];
    localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:timeIntervel];
    localNotification.alertBody = body;
    localNotification.soundName = UILocalNotificationDefaultSoundName;
    localNotification.applicationIconBadgeNumber = 1;
    localNotification.userInfo = @{@"id" : identifier};
    UIUserNotificationSettings *notificationSettings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert | UIUserNotificationTypeSound | UIUserNotificationTypeBadge categories:nil];
    [[UIApplication sharedApplication] registerUserNotificationSettings:notificationSettings];
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
}
@end
