//
//  SXQReagentDescView.h
//  实验助手
//
//  Created by sxq on 15/12/3.
//  Copyright © 2015年 SXQ. All rights reserved.
//
@class SXQAdjacentUser;
#import <UIKit/UIKit.h>

@interface SXQReagentDescView : UIView
+ (instancetype)reagentDescView;
@property (nonatomic,strong) SXQAdjacentUser *adjacentUser;
@end
