//
//  UIButton+Action.h
//  实验助手
//
//  Created by sxq on 15/11/16.
//  Copyright © 2015年 SXQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Action)
+ (instancetype)buttonWithTitle:(NSString *)title action:(void (^)())action;
@end
