//
//  DWAddStepViewModel.m
//  实验助手
//
//  Created by sxq on 15/12/15.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import <ActionSheetDatePicker.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "DWAddStepViewModel.h"
#import "DWAddExpStep.h"
@interface DWAddStepViewModel ()
@property (nonatomic,assign) NSUInteger stepTime;
@end
@implementation DWAddStepViewModel
- (instancetype)initWithInstructionID:(NSString *)instructionID
{
    DWAddExpStep *stepModel = [[DWAddExpStep alloc] initWithInstructionID:instructionID];
    return [self initWithModel:stepModel];
}
- (instancetype)initWithModel:(DWAddExpStep *)stepModel
{
    if (self = [super init]) {
        _addExpStep = stepModel;
        _stepTime = stepModel.expStepTime;
        _stepNum = stepModel.stepNum;
        _stepContent = stepModel.expStepDesc;
        _stepTimeStr = [NSString stringWithFormat:@"%lu分钟",(unsigned long)stepModel.expStepTime];
        
    
        [self bindingModel];
        [self p_setupTimeCommand];
    }
    return self;
}
- (void)bindingModel
{
    @weakify(self)
    [RACObserve(self, stepContent)
    subscribeNext:^(NSString *desc) {
        @strongify(self)
        self.addExpStep.expStepDesc = desc;
    }];
    [RACObserve(self, stepTime)
    subscribeNext:^(NSNumber *stepTime) {
        @strongify(self)
        self.addExpStep.expStepTime = [stepTime integerValue];
    }];
    [[RACObserve(self, stepTime)
     map:^id(NSNumber *stepTime) {
         if ([stepTime integerValue] == 0) {
                 return @"设置时间";
             }else
             {
                 return [NSString stringWithFormat:@"%lu分钟",(unsigned long)[stepTime integerValue]];
             }
        }]
    subscribeNext:^(NSString *timeStr) {
        @strongify(self)
        self.stepTimeStr  = timeStr;
    }];
    
    [RACObserve(self, stepNum)
     subscribeNext:^(NSNumber *stepNum) {
        @strongify(self)
         self.addExpStep.stepNum = [stepNum integerValue];
     }];
}
- (NSString *)stepImageName
{
    NSString *imageName = [NSString stringWithFormat:@"step%lu",(unsigned long)_stepNum];
    return imageName;
}
- (void)p_setupTimeCommand
{
    _chooseTimeCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            [self showTimePickerWithOrigin:input];
            [subscriber sendCompleted];
            return nil;
        }];
    }];
}
- (void)showTimePickerWithOrigin:(id)origin
{
    [ActionSheetDatePicker showPickerWithTitle:@"" datePickerMode:UIDatePickerModeCountDownTimer selectedDate:nil doneBlock:^(ActionSheetDatePicker *picker, NSNumber *seconds, id origin) {
        self.stepTime = [seconds integerValue]/60;
    } cancelBlock:^(ActionSheetDatePicker *picker) {
        
    } origin:origin];
}
- (void)setIndexPath:(NSIndexPath *)indexPath
{
    _indexPath = indexPath;
    self.stepNum = indexPath.row + 1;
}
@end
