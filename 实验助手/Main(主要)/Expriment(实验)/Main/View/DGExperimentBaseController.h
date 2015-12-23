//
//  DGExperimentBaseController.h
//  实验助手
//
//  Created by SXQ on 15/10/25.
//  Copyright © 2015年 SXQ. All rights reserved.
//
@class SXQExperimentModel,ArrayDataSource,CellContainerViewModel,RACSignal;
#import "SXQExperimentServices.h"
#import <UIKit/UIKit.h>

@interface DGExperimentBaseController : UIViewController
@property (nonatomic,strong) id<SXQExperimentServices> services;
@property (nonatomic,strong) SXQExperimentModel *experimentModel;
@property (nonatomic,strong) ArrayDataSource *arrDataSource;
@property (nonatomic,weak) CellContainerViewModel *currentViewModel;
- (instancetype)initWithExperimentModel:(SXQExperimentModel *)experimentModel;
- (RACSignal *)launchSignalWithModel:(CellContainerViewModel *)viewModel;
- (void)dg_activeAllStep;
@end
