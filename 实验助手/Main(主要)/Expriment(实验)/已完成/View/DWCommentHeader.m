//
//  DWCommentHeader.m
//  实验助手
//
//  Created by sxq on 15/12/8.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "DWStarView.h"
#import "DWCommentHeader.h"
#import "DWCommentHeaderViewModel.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
@interface DWCommentHeader ()
@property (nonatomic,weak) IBOutlet UILabel *commentItemLabel;
@property (nonatomic,weak) IBOutlet DWStarView *starView;
@property (nonatomic,weak) IBOutlet UIButton *foldBtn;
@end
@implementation DWCommentHeader
- (void)awakeFromNib
{
    self.foldBtn.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.foldBtn.imageView.layer.anchorPoint = CGPointMake(0.5f, 0.5f);
}
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self =  [super initWithReuseIdentifier:reuseIdentifier]) {
    }
    return self;
}
- (UIView *)contentView
{
    return self.subviews[0];
}
- (void)setViewModel:(DWCommentHeaderViewModel *)viewModel
{
    
    _viewModel = viewModel;
    
    [UIView animateWithDuration:0.4 animations:^{
        self.foldBtn.imageView.transform = self.viewModel.opened? CGAffineTransformIdentity : CGAffineTransformMakeRotation(-M_PI_2);
    }];
    self.commentItemLabel.text = viewModel.groupName;
    [[RACObserve(self.viewModel,groupScore) takeUntil:self.rac_prepareForReuseSignal]
     subscribeNext:^(NSNumber *groupScore) {
        self.starView.scores = [groupScore integerValue];
    }];
    
}
- (IBAction)foldBtnClicked:(UIButton *)button
{
    
    self.viewModel.opened = !self.viewModel.opened;
    
    if ([self.delegate respondsToSelector:@selector(commentHeaderClickedFoldBtn:)]) {
        [self.delegate commentHeaderClickedFoldBtn:self];
    }
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self foldBtnClicked:self.foldBtn];
}
@end
