//
//  SXQAddReagentExchangeController.m
//  实验助手
//
//  Created by sxq on 15/12/3.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "UIBarButtonItem+SXQ.h"
#import "SXQAddReagentExchangeController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "MBProgressHUD+MJ.h"
@interface SXQAddReagentExchangeController ()<UITextViewDelegate>
@property (nonatomic,strong) id<DWReagentExchangeTool> reagentExchangeTool;
@property (nonatomic,weak) IBOutlet UITextView *reagentView;
@end

@implementation SXQAddReagentExchangeController
- (instancetype)initWithReagentExchangeTool:(id<DWReagentExchangeTool>)reagentExchangeTool
{
    if (self = [super init]) {
        _reagentExchangeTool = reagentExchangeTool;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self p_setNavigationItem];
}
- (void)p_setNavigationItem
{
    self.title = @"发布试剂";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTitle:@"取消" titleColor:[UIColor redColor] font:15 action:^{
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTitle:@"确定" titleColor:[UIColor blueColor] font:15 action:^{
        [self.reagentExchangeTool setReagentWithReagentName:self.reagentView.text];
    }];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [button setTitle:@"确定" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    button.frame = CGRectMake(0, 0, 44, 30);
    RAC(button,enabled) = [self.reagentView.rac_textSignal map:^id(NSString *value) {
        return @(value.length > 0);
    }];
    @weakify(self)
   [[[[button rac_signalForControlEvents:UIControlEventTouchUpInside]
    doNext:^(id x) {
        button.enabled = NO;
    }]
    flattenMap:^RACStream *(id value) {
        @strongify(self)
        return [self.reagentExchangeTool setReagentWithReagentName:self.reagentView.text];
    }]
    subscribeNext:^(NSNumber *success) {
        @strongify(self)
        if ([success boolValue]) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }else
        {
            button.enabled = YES;
            [MBProgressHUD showError:@"发布失败"];
        }
    }];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@"请输入试剂名"]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor]; //optional
    }
    [textView becomeFirstResponder];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@""]) {
        textView.text = @"请输入试剂名";
        textView.textColor = [UIColor lightGrayColor]; //optional
    }
    [textView resignFirstResponder];
}
@end
