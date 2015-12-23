//
//  DWInstructionDetailCell.m
//  实验助手
//
//  Created by sxq on 15/11/16.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "DWInstructionDetailViewModel.h"
#import "DWInstructionDetailCell.h"
@interface DWInstructionDetailCell ()
@property (nonatomic,weak) IBOutlet UILabel *itemName;
@end
@implementation DWInstructionDetailCell

- (void)awakeFromNib {
    // Initialization code
//    self.backgroundColor = [UIColor redColor];
}
- (void)setViewModel:(DWInstructionDetailViewModel *)viewModel
{
    _viewModel = viewModel;
    self.itemName.text = viewModel.itemName;
}
@end
