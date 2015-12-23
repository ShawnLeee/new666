//
//  DWDoingViewModel.m
//  实验助手
//
//  Created by sxq on 15/11/13.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "MBProgressHUD+MJ.h"
#import "SXQExperimentModel.h"
#import "DWDoingViewModel.h"
#import "DWDoingModelService.h"
@interface DWDoingViewModel ()
@property (nonatomic,strong) SXQExperimentModel *experimentModel;
@property (nonatomic,strong) MBProgressHUD *hud;
@end
@implementation DWDoingViewModel
- (instancetype)initWithExperimentModel:(SXQExperimentModel *)experimentModel
{
    if (self = [super init]) {
        _experimentModel = experimentModel;
        _isShowingActionBar = NO;
        
        [self p_bindingModel];
    }
    return self;
}
- (void)p_bindingModel
{
    self.experimentName = _experimentModel.experimentName;
    self.expInstructionID = _experimentModel.expInstructionID;
    self.myExpID = _experimentModel.myExpID;
    @weakify(self)
   _showActionBarCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
       @strongify(self)
       self.isShowingActionBar = !self.isShowingActionBar;
       return [self.service dw_reloadData];
   }];
    _reportCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        return [[self.experimentService getServices] createReportWithMyExpId:self.experimentModel.myExpID];
    }];
    [[[[_reportCommand.executionSignals
       doNext:^(id x) {
           @strongify(self)
          self.hud = [MBProgressHUD showMessage:@"处理中..."];
       }]
    switchToLatest] takeUntil:self.cell.rac_prepareForReuseSignal]
    subscribeNext:^(NSNumber *success) {
        @strongify(self)
        if ([success boolValue]) {
            [self.hud hide:YES];
            [MBProgressHUD showSuccess:@"已生成"];
        }else
        {
            [self.hud hide:YES];
            [MBProgressHUD showError:@"请先评论"];
        }
    }
    error:^(NSError *error) {
        [MBProgressHUD showError:@"生成失败"];
     }];
    _commentCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            [self.service presentCommentControllerWithViewModel:self];
            return nil;
        }];
    }];
    _viewCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            [self.service presentReportWithMyExpId:self.experimentModel.myExpID];
            return nil;
        }];
    }];
}

@end
