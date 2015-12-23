//
//  DGExperimentBaseController+Signal.m
//  实验助手
//
//  Created by sxq on 15/10/26.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "SXQRemarkController.h"
#import "SXQExperimentModel.h"
#import "SXQExpStep.h"
#import "SXQNavgationController.h"
#import "MBProgressHUD+MJ.h"
#import "DGExperimentBaseController+Signal.h"
#import "DWExperimentToolBar.h"
#import "SXQSaveReagentController.h"
#import "CellContainerViewModel.h"

@implementation DGExperimentBaseController (Signal)
- (RACSignal *)isChoosingSignal
{
    @weakify(self)
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self)
        if ([self currentViewModel] == nil) {
            [MBProgressHUD showError:@"请选择试验步骤!"];
        }
        [subscriber sendNext:@([self currentViewModel] != nil)];
        [subscriber sendCompleted];
        return nil;
    }];
}
- (void)addReagentLocation
{
}
- (void)showPopoverWithItem:(CellContainerViewModel *)currentViewModel sender:(UIButton *)sender
{
    SXQSaveReagentController *saveReagentVC = [[SXQSaveReagentController alloc] init];
    SXQNavgationController *nav = [[SXQNavgationController alloc] initWithRootViewController:saveReagentVC];
    [self.navigationController presentViewController:nav animated:YES completion:nil];
}
- (RACSignal *)isTimingSignal
{
    CellContainerViewModel *viewModel = [self currentViewModel];
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@(viewModel.isUseTimer)];
        [subscriber sendCompleted];
        return nil;
    }];
}

- (RACSignal *)isAddReagentLocation
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        UIAlertController *remarkAlerVC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *saveReagentAction = [UIAlertAction actionWithTitle:@"添加试剂保存位置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [subscriber sendNext:@(YES)];
        }];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [subscriber sendNext:@(NO)];
        }];
        [remarkAlerVC addAction:saveReagentAction];
        [remarkAlerVC addAction:cancelAction];
        [self.navigationController presentViewController:remarkAlerVC animated:YES completion:^{
        }];
        return nil;
    }];
}

@end
