//
//  SXQLoginContainer.m
//  实验助手
//
//  Created by sxq on 15/10/22.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "SXQColor.h"
#import "SXQLoginViewModel.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "SXQLoginContainer.h"
@interface SXQLoginContainer ()
@property (nonatomic,weak) IBOutlet UIView *view;
@property (nonatomic,assign) BOOL didSetupConstraints;
@property (nonatomic,weak) IBOutlet UITextField  *userNameField;
@property (nonatomic,weak) IBOutlet UITextField  *password;
@property (nonatomic,weak) IBOutlet UIButton *forgetBtn;
@property (nonatomic,weak) IBOutlet UIButton *logBtn;
@end
@implementation SXQLoginContainer
- (instancetype)initWithLoginViewModel:(SXQLoginViewModel *)viewModel
{
    if (self = [super init]) {
        _viewModel = viewModel;
    }
    return self;
}
- (instancetype)init
{
    if (self = [super init]) {
        [[NSBundle mainBundle] loadNibNamed:@"SXQLoginContainer" owner:self options:nil];
        _didSetupConstraints = NO;
        [self p_addSubviews];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [[NSBundle mainBundle] loadNibNamed:@"SXQLoginContainer" owner:self options:nil];
        _didSetupConstraints = NO;
        [self p_addSubviews];
    }
    return self;
}
- (void)setViewModel:(SXQLoginViewModel *)viewModel
{
    _viewModel = viewModel;
    RAC(viewModel,username) = _userNameField.rac_textSignal;
    RAC(viewModel,password) = _password.rac_textSignal;
    _logBtn.rac_command = viewModel.loginCmd;
    _forgetBtn.rac_command  = viewModel.forgetCmd;
    [viewModel.loginCmd.executionSignals
    subscribeNext:^(NSNumber *ss) {
        [self endEditing:YES];
    }];
}
-(void)p_addSubviews
{
    _view.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_view];
}

- (void)updateConstraints
{
    //Add constraints
    if (_didSetupConstraints == NO) {
        [self p_addConstraints];
        _didSetupConstraints = YES;
    }
    
    [super updateConstraints];
}
- (void)p_addConstraints
{
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_view attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_view attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0]];
}
- (void)awakeFromNib
{
    UIColor *titleColor = [UIColor colorWithRed:0.00 green:0.64 blue:0.70 alpha:1.0];
    [self.forgetBtn setTitleColor:titleColor forState:UIControlStateNormal];
}

@end
