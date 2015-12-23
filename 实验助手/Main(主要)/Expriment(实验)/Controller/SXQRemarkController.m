//
//  SXQRemarkController.m
//  实验助手
//
//  Created by sxq on 15/9/25.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "CellContainerViewModel.h"
#import "SXQExpStep.h"
#import "SXQRemarkController.h"

@interface SXQRemarkController ()
@property (weak, nonatomic) IBOutlet UITextView *remarkView;
@property (nonatomic,strong) CellContainerViewModel *viewModel;
@property (nonatomic,weak) UIButton *confirmBtn;
@property (nonatomic,copy) void (^completion)();
@end

@implementation SXQRemarkController
- (instancetype)initWithViewModel:(CellContainerViewModel *)viewModel completion:(void (^)())completion
{
    if (self = [super init]) {
        _viewModel = viewModel;
        self.completion = completion;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self p_setupSelf];
    [self p_setupNav];
    [self binding];
}
- (void)p_setupSelf
{
    
    _remarkView.text = _viewModel.processMemo;
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(0, 0, 40, 30);
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"写备注";
    self.navigationItem.titleView = label;
    [_remarkView becomeFirstResponder];
}
- (void)p_setupNav
{
    UIButton *button = [[UIButton alloc] init];
    
    [button setTitle:@"取消" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    button.frame = CGRectMake(0, 0, 40, 30);
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        self.completion();
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _confirmBtn = rightBtn;
    rightBtn.enabled = NO;
    rightBtn.frame = CGRectMake(0, 0, 40, 30);
    [rightBtn setTitle:@"确定" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
}
- (void)binding
{

    RAC(_confirmBtn,enabled) = [_remarkView.rac_textSignal map:^id(NSString *text) {
        return @(text.length > 0);
    }];
    [[_confirmBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        self.viewModel.processMemo = _remarkView.text;
//        [_viewModel.experimentStep saveProcessMemo:_remarkView.text];
        self.completion();
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }];
}

@end
