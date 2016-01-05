//
//  SXQMyInstructionCell.m
//  实验助手
//
//  Created by sxq on 15/9/15.
//  Copyright (c) 2015年 SXQ. All rights reserved.
//
#import "SXQMyGenericInstruction.h"
#import "SXQMyInstructionCell.h"
@interface SXQMyInstructionCell ()
@property (weak, nonatomic) IBOutlet UILabel *instructionNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *uploadTImeLabel;

@end
@implementation SXQMyInstructionCell
- (void)configureCellForItem:(SXQMyGenericInstruction *)item
{
    _instructionNameLabel.text = item.experimentName;
    _uploadTImeLabel.text =  item.uploadTime;
}
@end
