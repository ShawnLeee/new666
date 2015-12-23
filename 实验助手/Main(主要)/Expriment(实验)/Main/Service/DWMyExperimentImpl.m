//
//  DWExperiment.m
//  实验助手
//
//  Created by sxq on 15/10/27.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "Account.h"
#import "AccountTool.h"
#import "SXQDBManager.h"
#import "SXQHttpTool.h"
#import "SXQURL.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "DWMyExperimentImpl.h"

@implementation DWExperimentImpl
- (RACSignal *)createReportWithMyExpId:(NSString *)myexpid
{
    return [self synthesizeMyExperimentWithMyExpId:myexpid];
}
- (RACSignal *)synthesizeMyExperimentWithMyExpId:(NSString *)myexpid
{
    return [[[self myexperimentDataSignalWithMyExpId:myexpid]
            flattenMap:^RACStream *(NSDictionary *experimentData) {
                return [self jsonStrWithExperimentData:experimentData];
            }]
            flattenMap:^RACStream *(NSString *jsonStr) {
                return [self sendExperimentJsonStr:jsonStr myExpID:myexpid];
            }];
    return nil;
}
- (RACSignal *)myexperimentDataSignalWithMyExpId:(NSString *)myExpId
{
    RACScheduler *scheduler = [RACScheduler schedulerWithPriority:RACSchedulerPriorityBackground];
    return [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSDictionary *myexpData = [[SXQDBManager sharedManager] getMyExpDataWithMyExpId:myExpId];
        [subscriber sendNext:myexpData];
        [subscriber sendCompleted];
        return nil;
    }] subscribeOn:scheduler];
}
- (RACSignal *)sendExperimentJsonStr:(NSString *)jsonStr myExpID:(NSString *)myExpID
{
    NSString *userID = [AccountTool account].userID;
    NSDictionary *param = @{@"json" : jsonStr,@"myExpID": myExpID,@"userID" : userID};
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [SXQHttpTool postWithURL:SynExperimentURL params:param success:^(id json) {
            if([json[@"code"] isEqualToString:@"1"])
            {
                [subscriber sendNext:@(YES)];
            }else if([json[@"code"] isEqualToString:@"2"])
            {
                [subscriber sendNext:@(NO)];
            }
            [subscriber sendCompleted];
        } failure:^(NSError *error) {
            [subscriber sendError:error];
        }];
        return nil;
    }];
}
- (RACSignal *)jsonStrWithExperimentData:(NSDictionary *)experimentData
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSError *error = nil;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:experimentData options:NSJSONWritingPrettyPrinted error:&error];
        if (jsonData.length > 0 && error == nil) {
            NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            [subscriber sendNext:jsonStr];
            [subscriber sendCompleted];
        }else
        {
            [subscriber sendError:error];
        }
        return nil;
    }];
}
@end
