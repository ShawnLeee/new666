//
//  DWSignOutView.h
//  实验助手
//
//  Created by sxq on 15/12/7.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "DWMeService.h"
#import <UIKit/UIKit.h>

@interface DWSignOutView : UIView
+ (instancetype)signOutViewWithService:(id<DWMeService>)service;
- (instancetype)initWithService:(id<DWMeService>)service;
@end
