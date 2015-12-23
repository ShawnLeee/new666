//
//  SXQCountTimeView.m
//  实验助手
//
//  Created by sxq on 15/10/21.
//  Copyright © 2015年 SXQ. All rights reserved.
//

#import "SXQCountTimeView.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
@interface SXQCountTimeView ()
@property (nonatomic,weak) IBOutlet UIView *view;
@property (nonatomic,weak) IBOutlet UIButton *confirmBtn;
@property (nonatomic,weak) IBOutlet UIButton *cancelBtn;
@property (nonatomic,weak) IBOutlet UIDatePicker *pickerView;
@end
@implementation SXQCountTimeView
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.hidden = YES;
        [self setup];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        self.hidden = YES;
        [self setup];
    }
    return self;
}
- (void)setup
{
    [[NSBundle mainBundle] loadNibNamed:@"SXQCountTimeView" owner:self options:nil];
    _view.translatesAutoresizingMaskIntoConstraints = NO;
    _pickerView.datePickerMode = UIDatePickerModeCountDownTimer;
    [self addSubview:_view];
    _view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    [self setupCustomView];
}
- (IBAction)confirm:(UIButton *)sender {
    if ([_delegate respondsToSelector:@selector(countTimeView:choosedTime:)]) {
        [_delegate countTimeView:self choosedTime:self.pickerView.countDownDuration];
    }
}
- (IBAction)cancel:(UIButton *)sender {
    [self hide];
}


- (void)setupCustomView
{
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_view attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_view attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0]];
}
- (void)show
{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    self.frame = [UIScreen mainScreen].bounds;
    [self layoutIfNeeded];
    [UIView animateWithDuration:0.5 animations:^{
        self.hidden = NO;
    }];
}
- (void)hide
{
    [UIView animateWithDuration:0.5 animations:^{
        self.hidden = YES;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
@end
