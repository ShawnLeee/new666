//
//  UIButton+Action.m
//  实验助手
//
//  Created by sxq on 15/11/16.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "UIButton+Action.h"

@implementation UIButton (Action)
+ (instancetype)buttonWithTitle:(NSString *)title action:(void (^)())action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside]
    subscribeNext:^(id x) {
        action();
    }];
    return button;
}
@end
