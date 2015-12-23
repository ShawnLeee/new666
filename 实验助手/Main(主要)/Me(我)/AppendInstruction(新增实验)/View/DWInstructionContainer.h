//
//  DWInstructionContainer.h
//  实验助手
//
//  Created by sxq on 15/12/9.
//  Copyright © 2015年 SXQ. All rights reserved.
//
@class DWAddExpInstruction;
#import "DWAddInstructionService.h"
#import <UIKit/UIKit.h>

@interface DWInstructionContainer : UIView
@property (nonatomic,strong) DWAddExpInstruction *instructionViewModel;
@property (nonatomic,strong) id<DWAddInstructionService> addInstructionService;
@end
