//
//  DWForgetPassController.m
//  实验助手
//
//  Created by sxq on 15/12/7.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "MBProgressHUD+MJ.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "DWForgetPassController.h"
#import "NSString+Check.h"

@interface DWForgetPassController ()
@property (nonatomic,strong) id<SXQLogin> loginTool;
@property (nonatomic,weak) IBOutlet UIButton *sendBtn;
@property (nonatomic,weak) IBOutlet UITextField *emailField;
@end

@implementation DWForgetPassController
- (void)setBtn
{
    self.sendBtn.backgroundColor = DWRGB(0.00, 0.64, 0.70);
    self.sendBtn.layer.cornerRadius = 4;
}
- (instancetype)initWithLoginTool:(id<SXQLogin>)loginTool
{
    if (self = [super init]) {
        _loginTool = loginTool;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self p_setup];
    [self p_binding];
}
- (void)p_setup
{
    self.title = @"重置密码";
    [self setBtn];
}
- (void)p_binding
{
    @weakify(self)
    RAC(self.sendBtn,enabled) = [self.emailField.rac_textSignal map:^id(NSString *text) {
        return @(text.length > 0);
    }];
    [[[[[self.sendBtn rac_signalForControlEvents:UIControlEventTouchUpInside]
    doNext:^(id x) {
        @strongify(self)
        self.sendBtn.enabled = NO;
    }]
     filter:^BOOL(id value) {
        @strongify(self)
         if (![self.emailField.text dg_isValidMailbox]) {
             [MBProgressHUD showError:@"邮箱格式不正确"];
             self.sendBtn.enabled = YES;
         }
         return [self.emailField.text dg_isValidMailbox];
     }]
     flattenMap:^RACStream *(id value) {
        @strongify(self)
         return [self.loginTool forgetPassSignalWithEmailAddress:self.emailField.text];
     }]
    subscribeNext:^(NSNumber *success) {
        @strongify(self)
        if ([success boolValue]) {
            [MBProgressHUD showSuccess:@"邮件发送成功"];
            [self dismissViewControllerAnimated:YES completion:nil];
        }else
        {
            [MBProgressHUD showError:@"邮件发送失败,请重试"];
            self.sendBtn.enabled = YES;
        }
    }error:^(NSError *error) {
            [MBProgressHUD showError:@"邮件发送失败,请重试"];
            self.sendBtn.enabled = YES;
    }];
}
@end
