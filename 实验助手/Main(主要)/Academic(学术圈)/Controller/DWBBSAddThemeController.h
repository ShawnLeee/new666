//
//  DWBBSAddThemeController.h
//  实验助手
//
//  Created by sxq on 15/12/4.
//  Copyright © 2015年 SXQ. All rights reserved.
//
@class DWAddThemeParam;
#import "DWBBSTool.h"
#import <UIKit/UIKit.h>

@interface DWBBSAddThemeController : UIViewController
- (instancetype)initWithAddThemeParam:(DWAddThemeParam *)addThemeParam bbsTool:(id<DWBBSTool>)bbsTool;
@end
