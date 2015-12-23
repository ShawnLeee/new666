//
//  DWInstructionDisclosure.m
//  实验助手
//
//  Created by sxq on 15/11/16.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "DWInstructionNavViewModel.h"
#import "DWInstructionDisclosure.h"
@interface DWInstructionDisclosure ()
@property (nonatomic,weak) IBOutlet UILabel *contentLabel;
@end
@implementation DWInstructionDisclosure

- (void)awakeFromNib {
    // Initialization code
}
- (void)setViewModel:(DWInstructionNavViewModel *)viewModel
{
    _viewModel = viewModel;
    self.contentLabel.text = viewModel.title;
}
@end
