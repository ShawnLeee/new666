//
//  DWReviewTableController.h
//  实验助手
//
//  Created by sxq on 15/11/17.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "DWInstructionService.h"
#import <UIKit/UIKit.h>

@interface DWReviewTableController : UITableViewController
- (instancetype)initWithReviews:(NSArray *)reviews service:(id<DWInstructionService>)service;
@end
