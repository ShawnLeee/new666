//
//  DWReviewDetailFooter.m
//  实验助手
//
//  Created by sxq on 15/11/30.
//  Copyright © 2015年 SXQ. All rights reserved.
//

#import "DWReviewDetailFooter.h"
@interface DWReviewDetailFooter ()
@property (nonatomic,weak) IBOutlet UILabel *reviewInfoLabel;
@property (nonatomic,weak) IBOutlet UIImageView *bgView;
@end
@implementation DWReviewDetailFooter

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self.class) owner:self options:nil];
        [self addSubview:_bgView];
        [self p_setupConstraints];
    }
    return self;
}
- (void)p_setupConstraints
{
    _bgView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_bgView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_bgView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_bgView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_bgView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0]];
}
- (void)setReviewInfo:(NSString *)reviewInfo
{
    _reviewInfo = [reviewInfo copy];
    self.reviewInfoLabel.text = reviewInfo;
    self.reviewInfoLabel.preferredMaxLayoutWidth = CGRectGetWidth(self.reviewInfoLabel.frame);
}
@end
