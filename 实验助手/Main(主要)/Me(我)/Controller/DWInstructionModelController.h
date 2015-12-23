//
//  DWInstructionModelController.h
//  实验助手
//
//  Created by sxq on 15/12/18.
//  Copyright © 2015年 SXQ. All rights reserved.
//
@class DWAddInstructionViewModel;
#import "DWMeService.h"
#import <UIKit/UIKit.h>

@interface DWInstructionModelController : UITableViewController
- (instancetype)initWithService:(id<DWMeService>)service completion:(void (^)(DWAddInstructionViewModel  *addInstructionViewModel))completion;
@end
