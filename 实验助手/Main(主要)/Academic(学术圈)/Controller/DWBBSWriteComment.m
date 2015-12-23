//
//  DWBBSWriteComment.m
//  实验助手
//
//  Created by sxq on 15/12/2.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "MBProgressHUD+MJ.h"
#import "DWBBSCommentParam.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "DWBBSWriteComment.h"

@interface DWBBSWriteComment ()<UITextViewDelegate>
@property (nonatomic,weak) IBOutlet UITextView *commentView;
@property (nonatomic,strong) DWBBSCommentParam *param;
@property (nonatomic,strong) id<DWBBSTool> bbsTool;
@end

@implementation DWBBSWriteComment
- (instancetype)initWithCommentParam:(DWBBSCommentParam *)param bbsTool:(id<DWBBSTool>)bbsTool
{
    if (self = [super init]) {
        _param = param;
        _bbsTool = bbsTool;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self p_setupNavigationItem];
}
- (void)p_setupNavigationItem
{
    self.commentView.textColor = [UIColor lightGrayColor];
    self.commentView.font = [UIFont systemFontOfSize:15];
    RAC(self.param,reviewDetail) = _commentView.rac_textSignal;
    
    self.title = @"写评论";
    UIColor *normal = [UIColor colorWithRed:0.00 green:0.47 blue:0.85 alpha:1.0];
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    cancelButton.titleLabel.font = [UIFont systemFontOfSize:15];
    cancelButton.titleLabel.textAlignment = NSTextAlignmentLeft;
    [cancelButton setTitleColor:normal forState:UIControlStateNormal];
    cancelButton.frame = CGRectMake(0, 0, 40, 30);
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:cancelButton];
    @weakify(self)
    [[cancelButton rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(id x) {
         @strongify(self)
         [self dismissViewControllerAnimated:YES completion:nil];
    }];
    
    UIButton *sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sendBtn.frame = CGRectMake(0, 0, 40, 30);
    [sendBtn setTitle:@"发布" forState:UIControlStateNormal];
    sendBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [sendBtn setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    [sendBtn setTitleColor:normal forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:sendBtn];
    [[[[sendBtn rac_signalForControlEvents:UIControlEventTouchUpInside]
      doNext:^(id x) {
          sendBtn.enabled = NO;
      }]
     flattenMap:^RACStream *(id value) {
         @strongify(self)
         return [self.bbsTool commentWithParam:self.param];
     }]
     subscribeNext:^(NSNumber *success) {
         @strongify(self)
         if ([success boolValue]) {
             [self dismissViewControllerAnimated:YES completion:nil];
         }else
         {
             [MBProgressHUD showError:@"评论失败"];
             sendBtn.enabled = YES;
         }
    }];
    
    [[_commentView.rac_textSignal
     map:^id(NSString *text) {
         return @(text.length > 0);
     }]
     subscribeNext:^(NSNumber *valide) {
         sendBtn.enabled = [valide boolValue];
    }];
}
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@"请输入评论"]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor]; //optional
    }
    [textView becomeFirstResponder];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@""]) {
        textView.text = @"请输入评论";
        textView.textColor = [UIColor lightGrayColor]; //optional
    }
    [textView resignFirstResponder];
}
@end
