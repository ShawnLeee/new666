//
//  DGExperimentConclusionController.h
//  实验助手
//
//  Created by sxq on 16/1/8.
//  Copyright © 2016年 SXQ. All rights reserved.
//
@class SXQExperimentModel;
#import "SXQExperimentServices.h"
#import <UIKit/UIKit.h>

@interface DGExperimentConclusionController : UITableViewController
- (instancetype)initWithExperimentModel:(SXQExperimentModel *)experimentModel service:(id<SXQExperimentServices>)service;
@end
