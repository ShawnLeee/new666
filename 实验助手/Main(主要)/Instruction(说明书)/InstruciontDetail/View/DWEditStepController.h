//
//  DWEditStepController.h
//  实验助手
//
//  Created by sxq on 15/11/23.
//  Copyright © 2015年 SXQ. All rights reserved.
//
@class DWInstructionStepViewModel;
#import <UIKit/UIKit.h>
#import "DWInstructionService.h"

@interface DWEditStepController : UIViewController
- (instancetype)initWithViewModel:(DWInstructionStepViewModel *)viewModel service:(id<DWInstructionService>)service;
@end
