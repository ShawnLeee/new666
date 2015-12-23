//
//  SXQExpCategoryViewModel.m
//  实验助手
//
//  Created by sxq on 15/11/18.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "SXQInstructionSearchImpl.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "SXQExpCategory.h"
#import "SXQExpCategoryViewModel.h"
#import "DWInstructionMainHeader.h"
@interface SXQExpCategoryViewModel ()
@property (nonatomic,strong) SXQExpCategory *expCategory;
@property (nonatomic,strong) id<SXQInstructionService> service;
@end
@implementation SXQExpCategoryViewModel
- (instancetype)initWithExpCategory:(SXQExpCategory *)expCategory service:(id<SXQInstructionService>)service
{
    if (self = [super init]) {
        _expCategory = expCategory;
        _service = service;
        [self p_setupSelf];
    }
    return self;
}
- (void)p_setupSelf
{
    self.categoryName = self.expCategory.expCategoryName;
    self.expCategoryID = self.expCategory.expCategoryID;
    self.expSubCategories = self.expCategory.expSubCategories;
    _moreCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            [self.service pushViewModel:self];
            [subscriber sendCompleted];
            return nil;
        }];
    }];
    [[[_moreCommand.executionSignals switchToLatest] takeUntil:self.header.rac_prepareForReuseSignal]
    subscribeNext:^(id x) {
        
    }];
}
@end
