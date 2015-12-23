//
//  DWSignOutView.m
//  实验助手
//
//  Created by sxq on 15/12/7.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "DWSignOutView.h"
@interface DWSignOutView ()
@property (nonatomic,strong) id<DWMeService> service;
@property (nonatomic,weak) UIButton *signOutBtn;
@end
@implementation DWSignOutView
+ (instancetype)signOutViewWithService:(id<DWMeService>)service
{
    DWSignOutView *signOutView = [[[NSBundle mainBundle] loadNibNamed:@"DWSignOutView"
                                                                owner:nil
                                                              options:nil] lastObject];
    return signOutView;
}
- (void)awakeFromNib
{
    self.backgroundColor = [UIColor redColor];
    self.frame = CGRectMake(0, 0, 300, 40);
}
- (instancetype)initWithService:(id<DWMeService>)service
{
    if (self = [super init]) {
        _service = service;
        [self p_addCustomView];
        self.frame = CGRectMake(0, 0, 300, 40);
    }
    return self;
}
- (void)p_addCustomView
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundColor:LABBtnBgColor];
    button.layer.cornerRadius = 4;
    [button setTitle:@"注销" forState:UIControlStateNormal];
    [self addSubview:button];
    button.translatesAutoresizingMaskIntoConstraints = NO;
    self.signOutBtn = button;
    [self layoutBtn];
    [self bindingBtn];
}
- (void)bindingBtn
{
    @weakify(self)
    [[self.signOutBtn rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(id x) {
         @strongify(self)
         [self.service signOut];
    }];
     
}
- (void)layoutBtn
{
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.signOutBtn attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.signOutBtn attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.signOutBtn attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1.0 constant:10]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.signOutBtn attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:-10]];
}
@end
