//
//  SXQReviewDetailController.h
//  实验助手
//
//  Created by sxq on 15/11/9.
//  Copyright © 2015年 SXQ. All rights reserved.
//
@class SXQReview;
#import "SXQInstructionService.h"
#import "DWInstructionService.h"
#import <UIKit/UIKit.h>

@interface SXQReviewDetailController : UITableViewController
- (instancetype)initWithReview:(SXQReview *)review service:(id<DWInstructionService>)service;
@end
