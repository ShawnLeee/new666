//
//  DWReagentDetailController.h
//  实验助手
//
//  Created by sxq on 15/11/27.
//  Copyright © 2015年 SXQ. All rights reserved.
//
@class SXQExpReagent;
#import "DWInstructionService.h"
#import <UIKit/UIKit.h>

@interface DWReagentDetailController : UIViewController
- (instancetype)initWithExpReagent:(SXQExpReagent *)reagent service:(id<DWInstructionService>)service;
@end
