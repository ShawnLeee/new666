//
//  DWBBSAddThemeController.m
//  实验助手
//
//  Created by sxq on 15/12/4.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "MBProgressHUD+MJ.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "SXQColor.h"
#import "DWAddThemeParam.h"
#import "DWBBSAddThemeController.h"
#import "UIBarButtonItem+MJ.h"
@interface DWBBSAddThemeController ()<UITextViewDelegate>
@property(nonatomic, strong) id<DWBBSTool> bbsTool;
@property(nonatomic, strong) DWAddThemeParam *addThemeParam;
@property (nonatomic,weak) IBOutlet UITextField *themeField;
@property (nonatomic,weak) IBOutlet UITextView *themeDetailView;
@end

@implementation DWBBSAddThemeController
- (instancetype)initWithAddThemeParam:(DWAddThemeParam *)addThemeParam
                              bbsTool:(id<DWBBSTool>)bbsTool {
  if (self = [super init]) {
    _bbsTool = bbsTool;
    _addThemeParam = addThemeParam;
  }
  return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self p_bindingParam];
    [self p_setNavigationItem];
}
- (void)p_setNavigationItem {
    self.title = @"新帖子";
  self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithIcon:@"Cancel_Normal"
                                                               highIcon:@"Cancel_Highlight"
                                                                 target:self
                                                                 action:@selector(p_dismiss)];
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [rightButton setTitle:@"发布" forState:UIControlStateNormal];
    [rightButton setTitleColor:DWRGB(0.00, 0.47, 0.85) forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    rightButton.frame = CGRectMake(0, 0, 35, 30);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    @weakify(self)
    [[[[rightButton rac_signalForControlEvents:UIControlEventTouchUpInside]
    doNext:^(id x) {
        rightButton.enabled = NO;
    }]
    flattenMap:^RACStream *(id value) {
        @strongify(self)
        return [self.bbsTool addThemeWithParam:self.addThemeParam];
    }]
    subscribeNext:^(NSNumber *success) {
        if ([success boolValue]) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }else
        {
            rightButton.enabled = YES;
            [MBProgressHUD showError:@"发布失败"];
        }
    }];
    [self p_bindingSendBtn:rightButton];
}
- (void)p_bindingSendBtn:(UIButton *)sendBtn
{
    RACSignal *themeValidSignal = [self.themeField.rac_textSignal map:^id(NSString *themeText) {
        return @(themeText.length > 0);
    }];
    RACSignal *themeContentValidSignal = [self.themeDetailView.rac_textSignal map:^id(NSString *themeContentText) {
        return @(themeContentText.length > 0);
    }];
    RACSignal *sendBtnEnableSignal = [RACSignal combineLatest:@[themeValidSignal,themeContentValidSignal]
                                                       reduce:^id(NSNumber *themeValid,NSNumber *themeContentValid){
                                                           return @([themeValid boolValue] && [themeContentValid boolValue]);
                                                       }];
    RAC(sendBtn,enabled) = sendBtnEnableSignal;
    
}
- (void)p_bindingParam
{
    RAC(self.addThemeParam,topicName) = self.themeField.rac_textSignal;
    RAC(self.addThemeParam,topicDetail) = self.themeDetailView.rac_textSignal;
}
- (void)p_dismiss
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@"内容"]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor]; //optional
    }
    [textView becomeFirstResponder];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@""]) {
        textView.text = @"内容";
        textView.textColor = [UIColor lightGrayColor]; //optional
    }
    [textView resignFirstResponder];
}

@end
