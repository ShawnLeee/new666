//
//  DWMyExperimentServicesImpl.m
//  实验助手
//
//  Created by sxq on 15/10/27.
//  Copyright © 2015年 SXQ. All rights reserved.

//
#import "SXQExpReagent.h"
#import "DWReagentAmountViewModel.h"
#import "DWSupplierDelegate.h"
#import <ActionSheetCustomPicker.h>
#import "DWMyExperimentServicesImpl.h"
#import "DWMyExperimentImpl.h"
@interface DWMyExperimentServicesImpl ()
@property (nonatomic,strong) DWExperimentImpl *service;
@property (nonatomic,strong) NSArray *viewModels;
@end
@implementation DWMyExperimentServicesImpl
- (DWExperimentImpl *)service
{
    if (_service == nil) {
        _service = [DWExperimentImpl new];
    }
    return _service;
}
- (id<DWMyExperiment>)getServices
{
    return self.service;
}
- (RACSignal *)showSuppliersPickerWithSuppliers:(NSArray *)suppliers sender:(id)sender
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        DWSupplierDelegate *delegate = [[DWSupplierDelegate alloc] initWithSuppliers:suppliers doneBlock:^(SXQSupplier *supplier) {
            [subscriber sendNext:supplier];
            [subscriber sendCompleted];
        } cancelBlock:^{
            [subscriber sendNext:nil];
            [subscriber sendCompleted];
        }];
        [ActionSheetCustomPicker showPickerWithTitle:@"" delegate:delegate showCancelButton:YES origin:sender];
        return nil;
    }];
}
- (NSArray *)viewModelArrayWithModelArray:(NSArray *)modelArray
{
    NSMutableArray *tmpArray = [NSMutableArray array];
    [modelArray enumerateObjectsUsingBlock:^(SXQExpReagent *reagent, NSUInteger idx, BOOL * _Nonnull stop) {
        DWReagentAmountViewModel *viewModel = [[DWReagentAmountViewModel alloc] initWithReagent:reagent];
        viewModel.service = self;
        [tmpArray addObject:viewModel];
    }];
    self.viewModels = [tmpArray copy];
    return self.viewModels;
}
- (void)updateRepeateCountWithCount:(NSString *)count exception:(DWReagentAmountViewModel *)exceptionModel
{
    [self.viewModels enumerateObjectsUsingBlock:^(DWReagentAmountViewModel *viewModel, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([exceptionModel isEqual:viewModel]) {
            viewModel.repeatCount = count;
        }
    }];
}
@end
