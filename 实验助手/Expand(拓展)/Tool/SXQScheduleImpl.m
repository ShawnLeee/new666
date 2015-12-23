//
//  SXQScheduleImpl.m
//  实验助手
//
//  Created by sxq on 15/10/21.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "SXQAddScheduleParam.h"
#import <MJExtension/MJExtension.h>
#import "SXQHttpTool.h"
#import "SXQScheduleImpl.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "SXQScheduleParam.h"
#import "SXQURL.h"
#import "SXQExpPlan.h"
@implementation SXQScheduleImpl
- (RACSignal *)scheduleWithDate:(NSString *)date
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        SXQScheduleParam *param = [SXQScheduleParam paramWithDate:date];
        [SXQHttpTool getWithURL:ScheduleURL params:param.keyValues success:^(id json) {
            NSArray *arr = [SXQExpPlan objectArrayWithKeyValuesArray:json[@"data"]];
            [subscriber sendNext:arr];
            [subscriber sendCompleted];
        } failure:^(NSError *error) {
            if (error) {
                [subscriber sendError:error];
            }
        }];
        return nil;
    }];
}
- (RACSignal *)deleteScheduleSignalWithExpPlan:(SXQExpPlan *)expPlan
{
    NSDictionary *param = @{@"myExpPlanID" : expPlan.myExpPlanID};
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [SXQHttpTool getWithURL:DeleteScheduleURL params:param success:^(id json) {
            [subscriber sendNext:@([json[@"code"] isEqualToString:@"1"])];
            [subscriber sendCompleted];
        } failure:^(NSError *error) {
            
        }];
        return nil;
    }];
}
- (RACSignal *)addScheduleSignalWithExpPlan:(SXQExpPlan *)expPlan
{
    SXQAddScheduleParam *param = [self scheduleParamWithExpPlan:expPlan];
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [SXQHttpTool getWithURL:AddScheduleURL params:param.keyValues success:^(id json) {
            [subscriber sendNext:@([json[@"code"] isEqualToString:@"1"])];
            [subscriber sendCompleted];
        } failure:^(NSError *error) {
            
        }];
        return nil;
    }];
}
- (SXQAddScheduleParam *)scheduleParamWithExpPlan:(SXQExpPlan *)expPlan
{
    SXQAddScheduleParam *param = [SXQAddScheduleParam new];
    param.expInstructionID = expPlan.expInstructionID;
    param.date = expPlan.date;
    return param;
}
@end
