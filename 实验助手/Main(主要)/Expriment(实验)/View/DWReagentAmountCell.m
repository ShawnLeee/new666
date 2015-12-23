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
@interface DWReagentAmountCell ()
@property (nonatomic,weak) IBOutlet NSLayoutConstraint *widthConstraint;
@property (nonatomic,weak) IBOutlet UILabel *nameLabel;
@property (nonatomic,weak) IBOutlet UILabel *singleLabel;
@property (nonatomic,weak) IBOutlet UITextField *sampleField;
@property (nonatomic,weak) IBOutlet UITextField *repeatCountField;
@property (nonatomic,weak) IBOutlet UILabel *totalLabel;
@end
@implementation DWReagentAmountCell

- (void)awakeFromNib {
    // Initialization code
    self.widthConstraint.constant = ([UIScreen mainScreen].bounds.size.width - 20)/5.0;
    [self setNeedsUpdateConstraints];
    [self layoutIfNeeded];
}
- (void)setViewModel:(DWReagentAmountViewModel *)viewModel
{
    _viewModel = viewModel;
    self.nameLabel.text = viewModel.reagentName;
    self.singleLabel.text = viewModel.singleAmount;
    RAC(self.viewModel,sampleAmount) = [self.sampleField.rac_textSignal takeUntil:self.rac_prepareForReuseSignal];
    RAC(self.viewModel,repeatCount) = [self.repeatCountField.rac_textSignal takeUntil:self.rac_prepareForReuseSignal];
    [RACObserve(self.viewModel, totalAmount)
    subscribeNext:^(NSString *totalAmount) {
        self.totalLabel.text = totalAmount;
    }];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
