//
//  UILocalNotification+DG.h
//  NSLocalNotification
//
//  Created by sxq on 15/10/22.
//  Copyright © 2015年 sxq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILocalNotification (DG)
+ (void)localNotificationWithBody:(NSString *)body
                     timeIntervel:(NSTimeInterval)timeIntervel
                      indentifier:(NSString *)identifier;
@end
