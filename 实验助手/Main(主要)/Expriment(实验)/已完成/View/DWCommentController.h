//
//  DWCommentController.h
//  实验助手
//
//  Created by sxq on 15/11/23.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "DWDoingModelService.h"
#import <UIKit/UIKit.h>
@class DWDoingViewModel;
@interface DWCommentController : UITableViewController
- (instancetype)initWithViewModel:(DWDoingViewModel *)viewModel service:(id<DWDoingModelService>)service;
@end
