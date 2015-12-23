//
//  DWSignUpServiceImpl.m
//  实验助手
//
//  Created by sxq on 15/11/18.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "SXQHttpTool.h"
#import "LoginTool.h"
#import "MBProgressHUD+MJ.h"
#import "DWSignUpViewModel.h"
#import <MJExtension/MJExtension.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "DWSignUpServiceImpl.h"
#import "DWSignUpGroup.h"
#import "DWGroup.h"
#import "NSString+Check.h"

@implementation DWLocation
@end

@interface DWSignUpServiceImpl ()
@property (nonatomic,weak) UITableView *tabelView;

@end
@implementation DWSignUpServiceImpl
- (void)enableAction
{
    self.tabelView.userInteractionEnabled = YES;
}
- (void)disableAction
{
    self.tabelView.userInteractionEnabled = NO;
}
- (DWLocation *)location
{
    if (!_location) {
        _location = [DWLocation new];
    }
    return _location;
}
- (instancetype)initWithTableView:(UITableView *)tabelView
{
    if (self = [super init]) {
        _tabelView = tabelView;
    }
    return self;
}
- (void)dismissKeyBoard
{
    [self.tabelView endEditing:YES];
}
- (RACSignal *)signUpModelsSignal
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"signup.plist" ofType:nil];
        NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:filePath];
        DWSignUpGroup *group = [DWSignUpGroup objectWithKeyValues:dict];
        [subscriber sendNext:[self groupsWithSignUpGrop:group]];
        [subscriber sendCompleted];
        return nil;
    }];
}
- (NSArray *)groupsWithSignUpGrop:(DWSignUpGroup *)group
{
    DWGroup *group0 = [[DWGroup alloc] initWithWithHeader:@"必填项" footer:nil items:group.require];
    DWGroup *group1 = [[DWGroup alloc] initWithWithHeader:@"选填项" footer:nil items:group.optional];
    return @[group0,group1];
}
- (RACSignal *)signUpWithGrouData:(NSArray *)groups
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        DWGroup *group = groups[0];
        NSArray *items = group.items;
        
        if (![self userNameValideWithViewModel:items[0]]) {
            [subscriber sendNext:@(NO)];
            [subscriber sendCompleted];
        }else
        {
            if (![self emailValideWithViewModel:items[1]]) {
                [subscriber sendNext:@(NO)];
                [subscriber sendCompleted];
            }else
            {
                if (![self p_passwordValidWithViewModels:@[items[2],items[3]]]) {
                    [subscriber sendNext:@(NO)];
                    [subscriber sendCompleted];
                }else
                {
                    [[self signUpSignalWithGroups:groups] subscribeNext:^(NSNumber *success) {
                        [subscriber sendNext:success];
                        [subscriber sendCompleted];
                    }];
                }
            }
        }
        
        
        return nil;
    }];
}
- (BOOL)userNameValideWithViewModel:(DWSignUpViewModel *)userViewModel
{
    if (!(userViewModel.text.length > 3)) {
        [MBProgressHUD showError:@"请输入三位以上用户名"];
        return NO;
    }
    return YES;
}
- (BOOL)emailValideWithViewModel:(DWSignUpViewModel *)emailViewModel
{
    if (![emailViewModel.text dg_isValidMailbox]) {
        [MBProgressHUD showError:@"邮箱格式不正确"];
        return NO;
    }
    return YES;
}
- (BOOL)p_passwordValidWithViewModels:(NSArray *)viewModels
{
    DWSignUpViewModel *passViewModel = viewModels[0];
    DWSignUpViewModel *repassViewModel = viewModels[1];
    if (passViewModel.text.length < 3) {
        [MBProgressHUD showError:@"请输入6位以上密码"];
        return NO;
    }
    if (![passViewModel.text isEqualToString:repassViewModel.text]) {
        [MBProgressHUD showError:@"两次密码不匹配"];
        return NO;
    }
    return YES;
}
- (RACSignal *)signUpSignalWithGroups:(NSArray *)groups
{
    SignUpParam *param = [self paramWithGroups:groups];
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [LoginTool signUpWithParam:param completion:^(BOOL success) {
            [subscriber sendNext:@(success)];
            [subscriber sendCompleted];
        }];
        return nil;
    }];
}
- (SignUpParam *)paramWithGroups:(NSArray *)groups
{
    DWGroup *group0 = groups[0];
    NSArray *items0 = group0.items;
    DWSignUpViewModel *nameViewModel = items0[0];
    DWSignUpViewModel *emailViewModel = items0[1];
    DWSignUpViewModel *passWordViewModel = items0[2];
//    DWGroup *group1 = groups[1];
//    NSArray *items1 = group1.items;
    SignUpParam *param = [SignUpParam paramWithNickName:nameViewModel.text passwd:passWordViewModel.text email:emailViewModel.text telNo:nil provinceID:nil cityID:nil collegeID:nil labName:nil majorID:nil educationID:nil titleID:nil nState:nil nSource:nil];
    
    return param;
}
- (RACSignal *)schoolsSignal
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSDictionary *params = nil;
        if (self.location) {
            params = @{@"provinceID" : self.location.provinceId ? : @"",@"cityID" : self.location.cityID ? : @""};
        }
        [SXQHttpTool getWithURL:SchoolURL params:params success:^(id json) {
            if ([json[@"code"] isEqualToString:@"1"]) {
                [subscriber sendNext:json[@"data"]];
            }else
            {
                [subscriber sendNext:nil];
            }
            [subscriber sendCompleted];
        } failure:^(NSError *error) {
            [subscriber sendError:error];
        }];
        return nil;
    }];
}
- (RACSignal *)professionsSingal
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [SXQHttpTool getWithURL:ProfessionURL params:nil success:^(id json) {
            if ([json[@"code"] isEqualToString:@"1"]) {
                [subscriber sendNext:json[@"data"]];
            }else
            {
                [subscriber sendNext:nil];
            }
            [subscriber sendCompleted];
        } failure:^(NSError *error) {
            [subscriber sendError:error];
        }];
        return nil;
    }];
}
@end
