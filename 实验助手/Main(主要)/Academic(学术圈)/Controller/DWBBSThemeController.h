//
//  DWBBSThemeController.h
//  实验助手
//
//  Created by sxq on 15/12/1.
//  Copyright © 2015年 SXQ. All rights reserved.
//
@class DWBBSModel;
#import "DWBBSTool.h"
#import <UIKit/UIKit.h>

@interface DWBBSThemeController : UITableViewController
- (instancetype)initWithBBSModel:(DWBBSModel *)bbsModel bbsTool:(id<DWBBSTool>)bbsTool;
@property (nonatomic,strong) id<DWBBSTool> bbsTool;
@property (nonatomic,strong) DWBBSModel *bbsModel;
@end
