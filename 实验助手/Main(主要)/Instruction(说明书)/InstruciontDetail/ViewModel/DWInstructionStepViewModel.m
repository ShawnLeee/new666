//
//  DWInstructionStepViewModel.m
//  实验助手
//
//  Created by sxq on 15/11/17.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "SXQInstructionStep.h"
#import "DWInstructionStepViewModel.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
@interface DWInstructionStepViewModel ()
@property (nonatomic,strong) SXQInstructionStep *instructionStep;
@property (nonatomic,strong) id<DWInstructionService> service;
@end
@implementation DWInstructionStepViewModel
- (instancetype)initWithInstructionStep:(SXQInstructionStep *)instrucitonStep service:(id<DWInstructionService>)service
{
    if (self = [super init]) {
        _service = service;
        self.instructionStep = instrucitonStep;
        _editCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                [self.service pushViewModel:self];
                [subscriber sendCompleted];
                return nil;
            }];
        }];
    }
    return self;
}

- (void)setInstructionStep:(SXQInstructionStep *)instructionStep
{
    _instructionStep = instructionStep;
    self.time = [NSString stringWithFormat:@"%@分钟", instructionStep.expStepTime];
    self.stepIconName = [NSString stringWithFormat:@"step%d",instructionStep.stepNum];
    self.stepDesc = instructionStep.expStepDesc;
    
    [RACObserve(self, stepDesc)
    subscribeNext:^(NSString *stepDesc) {
        instructionStep.expStepDesc = stepDesc;
    }];
}

@end
