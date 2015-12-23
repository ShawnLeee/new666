//
//  DWDoingActionBar.m
//  实验助手
//
//  Created by sxq on 15/11/13.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "DWDoingViewModel.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "DWDoingActionBar.h"
#import "DWButton.h"
#define kActionBarHeight 44

@interface DWDoingActionBar ()
@property (weak, nonatomic) IBOutlet DWButton *reportBtn;
@property (weak, nonatomic) IBOutlet DWButton *commentBtn;
@property (nonatomic,strong) NSLayoutConstraint *heightContraint;
@end

@implementation DWDoingActionBar

static BOOL isLoaded = NO;
- (id)awakeAfterUsingCoder:(NSCoder *)aDecoder
{
    self = [super awakeAfterUsingCoder:aDecoder];
    if (!isLoaded) {
        isLoaded = YES;
        DWDoingActionBar *realView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([DWDoingActionBar class])
                                                               owner:nil
                                                             options:nil] lastObject];
        realView.translatesAutoresizingMaskIntoConstraints = NO;
        [self replaceAutolayoutConstrainsFromView:self toView:realView];
        return realView;
    }
    
    isLoaded = NO;
    
    return self;
}
- (void)replaceAutolayoutConstrainsFromView:(UIView *)placeholderView toView:(DWDoingActionBar *)realView
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
        if ([constraint.identifier isEqualToString:@"actionBarHeight"]) {
            realView.heightContraint = newConstraint;
        }
    }
}
- (void)awakeFromNib
{
    
//    self.image = [[UIImage imageNamed:@"cm2_btm_tab_left"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
    self.backgroundColor = [UIColor colorWithRed:0.21 green:0.22 blue:0.22 alpha:1.0];
}
- (void)setViewModel:(DWDoingViewModel *)viewModel
{
    _viewModel = viewModel;
    @weakify(self)
    [RACObserve(self.viewModel, isShowingActionBar)
     subscribeNext:^(NSNumber *isShowing) {
         @strongify(self)
         self.heightContraint.constant = [isShowing boolValue]? kActionBarHeight : 0;
     }];
    self.reportBtn.rac_command = _viewModel.reportCommand;
    self.commentBtn.rac_command = _viewModel.commentCommand;
//    self.viewBtn.rac_command = _viewModel.viewCommand;
}
@end
