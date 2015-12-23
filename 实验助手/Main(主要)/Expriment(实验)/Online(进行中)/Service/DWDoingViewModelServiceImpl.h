//
//  DWDoingViewModelServiceImpl.h
//  实验助手
//
//  Created by sxq on 15/11/13.
//  Copyright © 2015年 SXQ. All rights reserved.
//
@class UITableViewController;
#import "DWDoingModelService.h"
#import <Foundation/Foundation.h>

@interface DWDoingViewModelServiceImpl : NSObject<DWDoingModelService>
- (instancetype)initWithTableViewController:(UITableViewController *)tabelViewController;
@end
