//
//  DWReagentAmountCell.m
//  实验助手
//
//  Created by sxq on 15/11/20.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "DWReagentAmountViewModel.h"
#import "DWReagentAmountCell.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
NSString * const kAmountIsEditingNotification = @"kamountiseditingnotification";
@interface DWReagentAmountCell ()<UITextFieldDelegate>
@property (nonatomic,weak) IBOutlet UILabel *nameLabel;
@property (nonatomic,weak) IBOutlet UITextField *singleUseAmount;
@property (nonatomic,weak) IBOutlet UITextField *sampleField;
@property (nonatomic,weak) IBOutlet UITextField *repeatCountField;
@property (nonatomic,weak) IBOutlet UILabel *totalLabel;
@end
@implementation DWReagentAmountCell
- (void)awakeFromNib {
    // Initialization code
    [self setNeedsUpdateConstraints];
    [self layoutIfNeeded];
}
- (void)setViewModel:(DWReagentAmountViewModel *)viewModel
{
    _viewModel = viewModel;
    self.nameLabel.text = viewModel.reagentName;
    self.singleUseAmount.text = viewModel.singleAmount;
    @weakify(self)
    [[self.singleUseAmount.rac_textSignal takeUntil:self.rac_prepareForReuseSignal]
    subscribeNext:^(NSString *singleAmount) {
        @strongify(self)
        self.viewModel.singleAmount = singleAmount;
    }];
    [[self.sampleField.rac_textSignal takeUntil:self.rac_prepareForReuseSignal]
    subscribeNext:^(NSString *amount) {
        @strongify(self)
        self.viewModel.sampleAmount =  amount;
    }];
    [[self.repeatCountField.rac_textSignal takeUntil:self.rac_prepareForReuseSignal]
    subscribeNext:^(NSString *repeatCount) {
        @strongify(self)
        self.viewModel.repeatCount = repeatCount;
    }];
    
    [[RACObserve(self.viewModel, totalAmount) takeUntil:self.rac_prepareForReuseSignal]
    subscribeNext:^(NSString *totalAmount) {
        self.totalLabel.text = totalAmount;
    }];
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kAmountIsEditingNotification object:self userInfo:@{}];
}
@end

