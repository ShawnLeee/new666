//
//  DWInstructionMainHeader.m
//  实验助手
//
//  Created by sxq on 15/11/18.
//  Copyright © 2015年 SXQ. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>
#import "SXQExpCategoryViewModel.h"
#import "DWInstructionMainHeader.h"
@interface DWInstructionMainHeader ()
@property (nonatomic,weak) IBOutlet UILabel *expcategoryLabel;
@property (nonatomic,weak) IBOutlet UIButton *moreButton;
@end
@implementation DWInstructionMainHeader
- (void)setViewModel:(SXQExpCategoryViewModel *)viewModel
{
    _viewModel = viewModel;
    viewModel.header = self;
    self.expcategoryLabel.text = viewModel.categoryName;
    self.moreButton.rac_command = viewModel.moreCommand;
}
- (void)awakeFromNib
{
    self.backgroundColor = [UIColor whiteColor];
    self.expcategoryLabel.textColor = [UIColor colorWithRed:0.0 green:0.64 blue:0.70 alpha:1.0];
}
@end
