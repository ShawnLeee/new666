//
//  DWAppendInstructionController.h
//  实验助手
//
//  Created by sxq on 15/12/9.
//  Copyright © 2015年 SXQ. All rights reserved.
//
@class DWAddInstructionViewModel;
#import <UIKit/UIKit.h>

@interface DWAppendInstructionController : UIViewController
@property (nonatomic,strong) DWAddInstructionViewModel *addInstructionViewModel;
@property (nonatomic,assign) BOOL createFromModel;
@end
