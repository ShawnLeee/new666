//
//  DWDoingViewModelServiceImpl.m
//  实验助手
//
//  Created by sxq on 15/11/13.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "DWCommentParam.h"
#import "DWCommentHeaderViewModel.h"
#import "MBProgressHUD+MJ.h"
#import "DWReportViewController.h"
#import "Account.h"
#import "AccountTool.h"
#import <MJExtension/MJExtension.h>
#import "DWCommentGroup.h"
#import "SXQHttpTool.h"
#import "DWCommentViewModel.h"
#import "SXQNavgationController.h"
#import "DWCommentController.h"
#import "DWDoingViewModelToolImpl.h"
#import "DWDoingViewModelServiceImpl.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
@interface DWDoingViewModelServiceImpl ()
@property (nonatomic,strong) id<DWDoingViewModelTool> service;
@property (nonatomic,weak) UITableViewController *tableViewController;
@end
@implementation DWDoingViewModelServiceImpl
- (instancetype)initWithTableViewController:(UITableViewController *)tabelViewController
{
    if (self = [super init]) {
        _tableViewController = tabelViewController;
    }
    return self;
}
- (id<DWDoingViewModelTool>)service
{
    if (!_service) {
        _service = [[DWDoingViewModelToolImpl alloc] init];
    }
    return _service;
}
- (id<DWDoingViewModelTool>)getService
{
    return self.service;
}
- (RACSignal *)dw_reloadData
{
    @weakify(self)
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self)
        [self.tableViewController.tableView reloadData];
        [subscriber sendCompleted];
        return nil;
    }];
}
- (void)presentCommentControllerWithViewModel:(DWDoingViewModel *)viewModel
{
    DWCommentController *commentVc = [[DWCommentController alloc] initWithViewModel:viewModel service:self];
    SXQNavgationController *nav = [[SXQNavgationController alloc] initWithRootViewController:commentVc];
    [self.tableViewController presentViewController:nav animated:YES completion:nil];
}
- (RACSignal *)commentViewModelSignalWithInstructioinID:(NSString *)instructionID
{
    DWCommentParam *commentParam = [DWCommentParam paramWithInstructionID:instructionID];
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [SXQHttpTool postWithURL:CommentListURL params:commentParam.keyValues success:^(id json) {
            if ([json[@"code"] isEqualToString:@"1"]) {
                NSArray *models = [DWCommentGroup objectArrayWithKeyValuesArray:json[@"data"]];
                NSArray *viewModels = [self p_viewModelsWithModels:models];
                [subscriber sendNext:viewModels];
                [subscriber sendCompleted];
            }else
            {
                [subscriber sendNext:nil];
                [subscriber sendCompleted];
            }
        } failure:^(NSError *error) {
            [subscriber sendError:error];
        }];
        return nil;
    }];
}
- (NSArray *)p_viewModelsWithModels:(NSArray *)models
{
    __block NSMutableArray *tmpArray = [NSMutableArray array];
    [models enumerateObjectsUsingBlock:^(DWCommentGroup *commentGroup, NSUInteger idx, BOOL * _Nonnull stop) {
        DWCommentHeaderViewModel *viewModel = [[DWCommentHeaderViewModel alloc] initWithCommentGroup:commentGroup];
        [tmpArray addObject:viewModel];
    }];
    return [tmpArray copy];
}
- (RACSignal *)commentWithExpinstructionID:(NSString *)expInstructionID content:(NSString *)content viewModels:(NSArray *)viewModels
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSDictionary *commentData = [self reviewDataWithExpInstructionID:expInstructionID content:content viewModels:viewModels];
        NSString *jsonStr = [self jsonStrWithCommentData:commentData];
        NSDictionary *params = @{@"reviewJson" : jsonStr};
        [SXQHttpTool postWithURL:CommentURL params:params success:^(id json) {
            [subscriber sendNext:@([json[@"code"] isEqualToString:@"1"])];
            [subscriber sendCompleted];
        } failure:^(NSError *error) {
            [subscriber sendError:error];
        }];
        return nil;
    }];
}
- (NSDictionary *)reviewDataWithExpInstructionID:(NSString *)instructionId content:(NSString *)content viewModels:(NSArray *)viewModels
{
    NSString *userId = [[AccountTool account] userID];
    NSInteger expScore = [self averageWithViewModels:viewModels];
    return @{@"expInstructionID":instructionId?:@"",@"reviewerID":userId?:@"",@"reviewInfo":content?:@"",@"expScore": @(expScore),
             @"expReviewDetails":[self reviewDetailsWithViewModels:viewModels]};
}
- (NSInteger)averageWithViewModels:(NSArray *)viewModels
{
    __block NSInteger sum = 0;
    [viewModels enumerateObjectsUsingBlock:^(DWCommentHeaderViewModel *viewModel, NSUInteger idx, BOOL * _Nonnull stop) {
        sum += viewModel.groupScore;
    }];
    return sum/viewModels.count;
}
- (NSArray *)reviewDetailsWithViewModels:(NSArray *)viewModels
{
    __block NSMutableArray *tmpArray = [NSMutableArray array];
    [viewModels enumerateObjectsUsingBlock:^(DWCommentHeaderViewModel *viewModel, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDictionary *reviewItem = viewModel.commentGroup.keyValues;
        [tmpArray addObject:reviewItem];
    }];
    return [tmpArray copy];
}
- (NSString *)jsonStrWithCommentData:(NSDictionary *)commentData
{
        NSError *error = nil;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:commentData options:NSJSONWritingPrettyPrinted error:&error];
        if (jsonData.length > 0 && error == nil) {
            NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            return jsonStr;
        }else
        {
            return nil;
        }
        return nil;
}
- (void)presentReportWithMyExpId:(NSString *)myexpId
{
    NSDictionary *params = @{@"myExpID" : myexpId};
    [SXQHttpTool getWithURL:ExperimentReportDownloadURL params:params success:^(id json) {
        if ([json[@"code"] isEqualToString:@"1"]) {
            NSString *reportURLStr = json[@"data"][@"pdfPath"];
            DWReportViewController *reportVC = [[DWReportViewController alloc] initWithReportURLStr:reportURLStr];
            SXQNavgationController *nav = [[SXQNavgationController alloc]  initWithRootViewController:reportVC];
            [self.tableViewController presentViewController:nav animated:YES completion:nil];
        }else{
            [MBProgressHUD showError:@"暂时无法查看"];
        }
    } failure:^(NSError *error) {
        
    }];
}
- (RACSignal *)pdfURLSignalWithMyExpID:(NSString *)myExpID
{
    NSDictionary *params = @{@"myExpID" : myExpID};
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [SXQHttpTool getWithURL:ExperimentReportDownloadURL params:params success:^(id json) {
            if ([json[@"code"] isEqualToString:@"1"]) {
                NSString *reportURLStr = json[@"data"][@"pdfPath"];
                [subscriber sendNext:reportURLStr];
                [subscriber sendCompleted];
            }else{
                [MBProgressHUD showError:@"暂时无法查看"];
                [subscriber sendNext:nil];
                [subscriber sendCompleted];
            }
        } failure:^(NSError *error) {
        
        }];
        return nil;
    }];
    
}
@end
