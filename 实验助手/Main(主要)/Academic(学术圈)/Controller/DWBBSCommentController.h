//
//  DWBBSCommentController.h
//  实验助手
//
//  Created by sxq on 15/12/1.
//  Copyright © 2015年 SXQ. All rights reserved.
//
@class DWBBSTheme;
#import "DWBBSTool.h"
#import <UIKit/UIKit.h>

@interface DWBBSCommentController : UITableViewController
- (instancetype)initWithBBSTheme:(DWBBSTheme *)bbsTheme bbsTool:(id<DWBBSTool>)bbsTool;
@end
