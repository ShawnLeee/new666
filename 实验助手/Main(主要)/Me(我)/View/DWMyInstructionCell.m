//
//  DWMyInstructionCell.m
//  实验助手
//
//  Created by sxq on 16/1/5.
//  Copyright © 2016年 SXQ. All rights reserved.
//
#import "SXQExpInstruction.h"
#import "DWMyInstructionCell.h"
@interface DWMyInstructionCell ()
@property (nonatomic,weak) IBOutlet UILabel *instructionNameLabel;
@property (nonatomic,weak) IBOutlet UILabel *authorNameLabel;
@end
@implementation DWMyInstructionCell
- (void)setExpInstruction:(SXQExpInstruction *)expInstruction
{
    _expInstruction = expInstruction;
    self.instructionNameLabel.text = expInstruction.experimentName;
    self.authorNameLabel.text = [NSString stringWithFormat:@"%@ %@",expInstruction.supplierName,expInstruction.provideUser];
}
@end
