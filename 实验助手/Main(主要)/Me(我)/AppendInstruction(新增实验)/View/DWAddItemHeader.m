//
//  DWAddItemHeader.m
//  实验助手
//
//  Created by sxq on 15/12/10.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "DWAddItemViewModel.h"
#import "DWAddItemHeader.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
@interface DWAddItemHeader ()
@property (nonatomic,weak) IBOutlet UILabel *itemNameLabel;
@property (nonatomic,weak) IBOutlet UIButton *addButton;
@end
@implementation DWAddItemHeader
- (UIView *)contentView
{
    return [self.subviews firstObject];
}
- (void)setViewModel:(DWAddItemViewModel *)viewModel
{
    _viewModel = viewModel;
    self.contentView.backgroundColor = RGB(28, 146, 163);
    self.itemNameLabel.text = viewModel.itemName;
    self.addButton.rac_command = viewModel.addCommand;
}
@end
