//
//  DWInstructionServiceImpl.m
//  实验助手
//
//  Created by sxq on 15/11/17.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "SXQReviewDetail.h"
#import "SXQReview.h"
#import "SXQDBManager.h"
#import "DWReagentDetail.h"
#import <MJExtension/MJExtension.h>
#import "SXQHttpTool.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "DWReagentDetailController.h"
#import "SXQExpReagent.h"
#import "DWEditStepController.h"
#import "DWInstructionStepViewModel.h"
#import "DWInstructionContentController.h"
#import "DWReviewTableController.h"
#import "DWInstructionNavViewModel.h"
#import "DWInstructionDetailViewModel.h"
#import "DWInstructionServiceImpl.h"
#import "DWStepTableController.h"
@interface DWInstructionServiceImpl ()
@property (nonatomic,weak) UINavigationController *nav;
@end
@implementation DWInstructionServiceImpl
- (instancetype)initWithNavigationController:(UINavigationController *)nav
{
    if (self = [super init]) {
        _nav = nav;
    }
    return self;
}
- (void)pushViewModel:(id)viewModel
{
    if ([viewModel isKindOfClass:[DWInstructionNavViewModel class]]) {
        [self p_pushNavViewModel:(DWInstructionNavViewModel *)viewModel];
    }else if([viewModel isKindOfClass:[DWInstructionDetailViewModel class]])
    {
        [self p_pushDetailViewModel:(DWInstructionDetailViewModel *)viewModel];
    }else if([viewModel isKindOfClass:[DWInstructionStepViewModel class]])
    {
        [self p_pushStepViewModel:viewModel];
    }
    
}
- (void)p_pushStepViewModel:(DWInstructionStepViewModel *)stepViewModel
{
    DWEditStepController *editVC = [[DWEditStepController alloc] initWithViewModel:stepViewModel service:self];
    [self.nav pushViewController:editVC animated:YES];
}
- (void)p_pushNavViewModel:(DWInstructionNavViewModel *)viewModel
{
    switch (viewModel.vcType) {
        case InstructionDetaiVcTypeText:
        {
            DWInstructionContentController *contentVC = [[DWInstructionContentController alloc] initWithViewModel:viewModel];
            [self.nav pushViewController:contentVC animated:YES];
            break;
        }
        case InstructionDetaiVcTypeComment:
        {
            DWReviewTableController *reviewVC = [[DWReviewTableController alloc] initWithReviews:viewModel.items service:self];
            [self.nav pushViewController:reviewVC animated:YES];
            break;
        }
        case InstructionDetaiVcTypeSteps:
        {
            DWStepTableController *stepVC = [[DWStepTableController alloc] initWithSteps:viewModel.items service:self];
            [self.nav pushViewController:stepVC animated:YES];
            break;
        }
            
    }
}
- (void)p_pushDetailViewModel:(DWInstructionDetailViewModel *)viewModel
{
    if ([viewModel.model isKindOfClass:[SXQExpReagent class]]) {
        DWReagentDetailController *reagentDetailVC = [[DWReagentDetailController alloc] initWithExpReagent:viewModel.model service:self];
        [self.nav pushViewController:reagentDetailVC animated:YES];
    }
}
- (RACSignal *)reagentSignalWithReagentModel:(SXQExpReagent *)reagent
{
    NSDictionary *param = @{@"reagentID":reagent.reagentID,@"expInstructionID":reagent.expInstructionID};
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [SXQHttpTool getWithURL:ReagentDetailURL params:param success:^(id json) {
            DWReagentDetail *reagentDetail = [[DWReagentDetail alloc] init];
            if ([json[@"code"] isEqualToString:@"1"]) {
                reagentDetail = [DWReagentDetail objectWithKeyValues:json[@"data"]];
            }
            [subscriber sendNext:reagentDetail];
            [subscriber sendCompleted];
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
