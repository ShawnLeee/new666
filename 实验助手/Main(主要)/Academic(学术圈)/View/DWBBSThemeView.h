//
//  DWBBSThemeView.h
//  实验助手
//
//  Created by sxq on 15/12/4.
//  Copyright © 2015年 SXQ. All rights reserved.
//
@class DWBBSTopic;
#import "DWBBSTool.h"
#import <UIKit/UIKit.h>

@interface DWBBSThemeView : UIView
+ (instancetype)themeView;
+ (instancetype)themeViewWithBBSTool:(id<DWBBSTool>)bbsTool;
@property (nonatomic,strong) DWBBSTopic *bbsTopic;
@end
