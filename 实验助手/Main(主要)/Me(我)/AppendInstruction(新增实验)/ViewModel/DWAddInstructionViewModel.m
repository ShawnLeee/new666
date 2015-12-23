//
//  DWAddInstructionViewModel.m
//  实验助手
//
//  Created by sxq on 15/12/9.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "DWAddExpInstruction.h"
#import "DWAddInstructionViewModel.h"
#import "SXQDBManager.h"

@implementation DWAddInstructionViewModel
- (void)loadInstructionData
{
    [[SXQDBManager sharedManager] loadDataWithDWaddInstructionViewModel:self];
}
@end
