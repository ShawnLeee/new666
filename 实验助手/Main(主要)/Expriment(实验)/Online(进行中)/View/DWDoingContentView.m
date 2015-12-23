//
//  DWDoingContentView.m
//  实验助手
//
//  Created by sxq on 15/11/13.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "DWDoingViewModel.h"
#import "DWDoingContentView.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
@interface DWDoingContentView ()
@property (nonatomic,weak) IBOutlet UIButton *moreButton;
@property (nonatomic,weak) IBOutlet UILabel *contentLabel;
@end
@implementation DWDoingContentView

static BOOL isLoaded = NO;
- (id)awakeAfterUsingCoder:(NSCoder *)aDecoder
{
    self = [super awakeAfterUsingCoder:aDecoder];
    if (!isLoaded) {
        isLoaded = YES;
        UIImageView *realView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([DWDoingContentView class])
                                                               owner:nil
                                                             options:nil] lastObject];
        realView.translatesAutoresizingMaskIntoConstraints = NO;
        [self replaceAutolayoutConstrainsFromView:self toView:realView];
        return realView;
    }
    
    isLoaded = NO;
    return self;
}
- (void)replaceAutolayoutConstrainsFromView:(UIView *)placeholderView toView:(UIView *)realView
{
    for (NSLayoutConstraint *constraint in placeholderView.constraints)
    {
        NSLayoutConstraint* newConstraint  = [NSLayoutConstraint constraintWithItem:realView
                                                                          attribute:constraint.firstAttribute
                                                                          relatedBy:constraint.relation
                                                                             toItem:nil // Only first item
                                                                          attribute:constraint.secondAttribute
                                                                         multiplier:constraint.multiplier
                                                                           constant:constraint.constant];
        newConstraint.shouldBeArchived = constraint.shouldBeArchived;
        newConstraint.priority = constraint.priority;
        [realView addConstraint:newConstraint];
    }
}
- (void)setViewModel:(DWDoingViewModel *)viewModel
{
    _viewModel = viewModel;
    self.contentLabel.text = viewModel.experimentName;
    [self binding];
}
- (void)binding
{
    self.moreButton.rac_command = self.viewModel.showActionBarCommand;
    @weakify(self)
    [RACObserve(self.viewModel, isShowingActionBar)
     subscribeNext:^(id x) {
         @strongify(self)
         self.moreButton.selected = self.viewModel.isShowingActionBar;
    }];
}

@end
