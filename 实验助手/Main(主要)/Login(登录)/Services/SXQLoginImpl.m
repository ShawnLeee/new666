//
//  SXQLoginImpl.m
//  实验助手
//
//  Created by sxq on 15/10/22.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "SXQTitle.h"
#import "SXQDegree.h"
#import "SXQProfession.h"
#import "LoginTool.h"
#import "SXQLoginImpl.h"
#import <MJExtension/MJExtension.h>
#import "SXQHttpTool.h"
@implementation SXQLoginImpl
- (RACSignal *)loginSignalWithUsername:(NSString *)username password:(NSString *)password
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [LoginTool loginWithUserName:username password:password completion:^(BOOL success) {
            [subscriber sendNext:@(success)];
            [subscriber sendCompleted];
        }];
        return nil;
    }];
}
- (RACSignal *)schoolDataSignal
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [SXQHttpTool getWithURL:SchoolURL params:nil success:^(id json) {
            
        } failure:^(NSError *error) {
            
        }];
        return nil;
    }];
}
- (RACSignal *)provinceDataSignal
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [SXQHttpTool getWithURL:ProvinceURL params:nil success:^(id json) {
//            NSArray *provinceArray = [
        } failure:^(NSError *error) {
            
        }];
        return nil;
    }];
}
- (RACSignal *)degreeSignal
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [SXQHttpTool getWithURL:DegreeURL params:nil success:^(id json) {
            NSArray *degreeArray = [SXQDegree objectArrayWithKeyValuesArray:json[@"data"]];
            [subscriber sendNext:degreeArray];
            [subscriber sendCompleted];
        } failure:^(NSError *error) {
            
        }];
        return nil;
    }];
}
- (RACSignal *)indentitySignal
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [SXQHttpTool getWithURL:IdentityURL params:nil success:^(id json) {
            NSArray *identityArray = [SXQTitle objectArrayWithKeyValuesArray:json[@"data"]];
            [subscriber sendNext:identityArray];
            [subscriber sendCompleted];
        } failure:^(NSError *error) {
            
        }];
        return nil;
    }];
}
- (RACSignal *)forgetPassSignalWithEmailAddress:(NSString *)email
{
    NSDictionary *param = @{@"eMail" : email};
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [SXQHttpTool postWithURL:ForgetPassURL params:param success:^(id json) {
            [subscriber sendNext:@([json[@"code"] isEqualToString:@"1"])];
            [subscriber sendCompleted];
        } failure:^(NSError *error) {
            [subscriber sendNext:@(NO)];
            [subscriber sendCompleted];
        }];
        return nil;
    }];
}
@end
