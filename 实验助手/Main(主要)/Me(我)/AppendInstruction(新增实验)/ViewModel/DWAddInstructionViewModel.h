//
//  DWAddInstructionViewModel.h
//  实验助手
//
//  Created by sxq on 15/12/9.
//  Copyright © 2015年 SXQ. All rights reserved.
//
@class DWAddExpInstruction;
#import <Foundation/Foundation.h>

@interface DWAddInstructionViewModel : NSObject
@property (nonatomic,strong) DWAddExpInstruction *expInstruction;
@property (nonatomic,strong) NSArray *expReagent;
@property (nonatomic,strong) NSArray *expConsumable;
@property (nonatomic,strong) NSArray *expEquipment;
@property (nonatomic,strong) NSArray *expExpStep;
- (void)loadInstructionData;
@end
