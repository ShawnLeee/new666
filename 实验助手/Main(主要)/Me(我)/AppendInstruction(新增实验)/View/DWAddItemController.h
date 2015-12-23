//
//  DWAddItemController.h
//  实验助手
//
//  Created by sxq on 15/12/10.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "DWAddInstructionService.h"
#import <UIKit/UIKit.h>
@class DWAddInstructionViewModel;

@interface DWAddItemController : UITableViewController
@property (nonatomic,assign) BOOL createFromModel;
@property (nonatomic,strong) DWAddInstructionViewModel *addInstrucitonViewModel;

@end
