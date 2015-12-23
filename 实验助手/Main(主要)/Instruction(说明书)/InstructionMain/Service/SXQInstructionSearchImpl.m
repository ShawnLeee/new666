//
//  SXQInstructionSearchImpl.m
//  实验助手
//
//  Created by sxq on 15/10/29.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "SXQReviewDetail.h"
#import "SXQReview.h"
#import "SXQURL.h"
#import "SXQHttpTool.h"
#import "SXQInstructionSearchImpl.h"
#import "SXQExpInstruction.h"
#import <MJExtension/MJExtension.h>
#import "SXQDBManager.h"
@implementation SXQInstructionSearchImpl
- (RACSignal *)signalForSerchWithText:(NSString *)text
{
    NSDictionary *param = @{@"filterStr" : text};
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [SXQHttpTool getWithURL:SearchInstructionURL params:param success:^(id json) {
            if ([json[@"code"] isEqualToString:@"1"]) {
                NSArray *resultsArray = [SXQExpInstruction objectArrayWithKeyValuesArray:json[@"data"]];
                [subscriber sendNext:resultsArray];
                [subscriber sendCompleted];
            }else
            {
                [subscriber sendError:nil];
            }
        } failure:^(NSError *error) {
               [subscriber sendError:error];
        }];
        return nil;
    }];
}
- (RACSignal *)signalForSaveInstruction:(SXQInstructionDetail *)instructionDetail
{
    RACScheduler *scheduler = [RACScheduler schedulerWithPriority:RACSchedulerPriorityBackground];
    return [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [[SXQDBManager sharedManager] saveInstructionWithInstructionDetail:instructionDetail succeed:^(BOOL succeed) {
            [subscriber sendNext:@(succeed)];
            [subscriber sendCompleted];
        }];
        return nil;
    }] subscribeOn:scheduler];
}
- (RACSignal *)reviewDetailSignalWithReview:(SXQReview *)review
{
    NSDictionary *params = @{@"expReviewID" : review.expReviewID};
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [SXQHttpTool getWithURL:CommentDetailURL params:params success:^(id json) {
            if ([json[@"code"] integerValue]== LABResponseTypeSuccess) {
                SXQReviewDetail *reviewDetail = [SXQReviewDetail objectWithKeyValues:json[@"data"]];
                [subscriber sendNext:reviewDetail];
                [subscriber sendCompleted];
            }
        } failure:^(NSError *error) {
            [subscriber sendError:error];
        }];
        return nil;
    }];
}
@end
