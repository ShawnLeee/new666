//
//  DWAddStepCell.m
//  实验助手
//
//  Created by sxq on 15/12/15.
//  Copyright © 2015年 SXQ. All rights reserved.
//

#import "DWAddStepCell.h"
#import "DWAddStepViewModel.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
@interface DWAddStepCell ()<UITextViewDelegate>
@property (nonatomic,weak) IBOutlet UIImageView *stepImageView;
@property (nonatomic,weak) IBOutlet UITextView *stepContentView;
@property (nonatomic,weak) IBOutlet UILabel *timeLabel;
@property (nonatomic,weak) IBOutlet UIButton *timeButton;
@property (nonatomic,weak) IBOutlet NSLayoutConstraint *heightConstraint;
@end
@implementation DWAddStepCell

- (void)setStepViewModel:(DWAddStepViewModel *)stepViewModel
{
    
    _stepViewModel = stepViewModel;
    
    self.stepContentView.text = stepViewModel.stepContent;
    [self bindingViewModel];
}
- (void)bindingViewModel
{
    self.timeButton.rac_command = self.stepViewModel.chooseTimeCommand;
    [[self.timeButton rac_signalForControlEvents:UIControlEventTouchUpInside]
    subscribeNext:^(id x) {
        [self.tableView endEditing:YES];
    }];
    @weakify(self)
    [[self.stepContentView.rac_textSignal takeUntil:self.rac_prepareForReuseSignal]
    subscribeNext:^(NSString *text) {
        @strongify(self)
        self.stepViewModel.stepContent = text;
    }];
    
    RAC(self.timeLabel,text) = [RACObserve(self.stepViewModel, stepTimeStr) takeUntil:self.rac_prepareForReuseSignal];
    RAC(self.stepImageView,image) = [[RACObserve(self.stepViewModel, stepImageName) takeUntil:self.rac_prepareForReuseSignal]
                                     map:^id(NSString *imageName) {
                                         return [UIImage imageNamed:imageName];
                                     }];
//    [[self.stepContentView.rac_textSignal takeUntil:self.rac_prepareForReuseSignal]
//    subscribeNext:^(id x) {
//        @strongify(self)
//        CGSize sizeThatShouldFitTheConstent = [self.stepContentView sizeThatFits:self.stepContentView.frame.size];
//        self.heightConstraint.constant = sizeThatShouldFitTheConstent.height;
//        [self.tableView layoutIfNeeded];
//    }];

    
    
}


@end
