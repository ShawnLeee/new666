//
//  SXQLoginController.m
//  实验助手
//
//  Created by sxq on 15/10/22.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "AppDelegate.h"
#import "SXQColor.h"
#import "SXQVenderLogin.h"
#import "DWSignUpLogicController.h"
#import "SXQNavgationController.h"
#import "SXQLoginController.h"
#import "SXQLoginViewModel.h"
#import "SXQLoginContainer.h"
#import "SXQLoginViewModelServiceImpl.h"
#import "MBProgressHUD+MJ.h"
@interface SXQLoginController ()
@property (weak, nonatomic) IBOutlet SXQVenderLogin *venderView;
@property (weak, nonatomic) IBOutlet SXQLoginContainer *loginContainer;
@property (nonatomic,strong) SXQLoginViewModel *viewModel;
@property (nonatomic,strong) SXQLoginViewModelServiceImpl *service;
@end

@implementation SXQLoginController
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self.venderView setNeedsUpdateConstraints];
    [self.venderView layoutIfNeeded];
}
- (SXQLoginViewModelServiceImpl *)service
{
    if (!_service) {
        _service = [[SXQLoginViewModelServiceImpl alloc] initWithNavigationController:self.navigationController];
    }
    return _service;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        _viewModel = [[SXQLoginViewModel alloc] initWithService:self.service];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self p_setupSelf];
    self.loginContainer.viewModel = _viewModel;
    
    [[_viewModel.loginCmd.executionSignals switchToLatest]
    subscribeNext:^(NSNumber *isLoginSuccess) {
        if ([isLoginSuccess boolValue]) {
            //切换根控制器
            [AppDelegate chooseRootController];
        }else
        {
            [MBProgressHUD showError:@"用户名或密码错误"];
        }
    }];
}
- (void)p_setupSelf
{
    self.title = @"登录";
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, 60, 30);
    [button setTitle:@"取消" forState:UIControlStateNormal];
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}
- (UIViewController *)mainRootViewController
{
    return [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateInitialViewController];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [_loginContainer endEditing:YES];
}


@end
