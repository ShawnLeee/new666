//
//  DWSignUpCell.m
//  实验助手
//
//  Created by SXQ on 15/11/19.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "DWSignUpViewModel.h"
#import "DWSignUpCell.h"
@interface DWSignUpCell ()
@property (nonatomic,weak) IBOutlet UILabel *titleLabel;
@property (nonatomic,weak) IBOutlet UITextField *inputField;
@end
@implementation DWSignUpCell
- (void)setViewModel:(DWSignUpViewModel *)viewModel
{
    _viewModel = viewModel;
    self.titleLabel.text = viewModel.title;
    [RACObserve(self.viewModel, text)
    subscribeNext:^(NSString *text) {
        self.inputField.text = text;
    }];
    self.inputField.placeholder = viewModel.placeholder;
    self.inputField.delegate = viewModel;
    RAC(self.viewModel,text) = [self.inputField.rac_textSignal takeUntil:self.rac_prepareForReuseSignal];
}
@end
