//
//  SXQExperimentServices.h
//  实验助手
//
//  Created by sxq on 15/10/23.
//  Copyright © 2015年 SXQ. All rights reserved.
//
@class RACSignal;
#import <Foundation/Foundation.h>
#import "DWExperimentStep.h"
@class CellContainerViewModel;
@protocol SXQExperimentServices <NSObject>
- (id<DWExperimentStep>)getServices;
- (RACSignal *)imagePickedSignal;
- (RACSignal *)remarkAddSignalWithViewModel:(CellContainerViewModel *)viewModel;
- (RACSignal *)launchSignalWithViewModel:(CellContainerViewModel *)viewModel;
- (RACSignal *)setCompleteWithMyExpId:(NSString *)myExpId;
- (void)activeAllStep;
@end
