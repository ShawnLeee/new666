//
//  SXQExperimentStepImpl.m
//  实验助手
//
//  Created by sxq on 15/10/23.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "SXQDBManager.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "SXQExperimentStepImpl.h"

@implementation SXQExperimentStepImpl
- (RACSignal *)experimentStepSignalWithMyExpId:(NSString *)myexpid
{
    RACScheduler *scheduler = [RACScheduler schedulerWithPriority:RACSchedulerPriorityBackground];
    return [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [[SXQDBManager sharedManager] loadCurrentDataWithMyExpId:myexpid
                                                      completion:^(SXQCurrentExperimentData *currentExprimentData) {
                                                          [subscriber sendNext:currentExprimentData];
                                                          [subscriber sendCompleted];
            
        }];
        return nil;
    }] subscribeOn:scheduler];
}
@end
