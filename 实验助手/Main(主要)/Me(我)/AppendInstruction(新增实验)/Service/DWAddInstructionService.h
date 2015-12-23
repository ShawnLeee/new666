//
//  DWAddInstructionService.h
//  实验助手
//
//  Created by sxq on 15/12/10.
//  Copyright © 2015年 SXQ. All rights reserved.
//
@class RACSignal,UIViewController,DWAddInstructionViewModel;
#import <Foundation/Foundation.h>

@protocol DWAddInstructionService <NSObject>
- (RACSignal *)firstCategorySignal;
- (RACSignal *)secondCategorySignalWithCategoryID:(NSString *)categoryID;
- (RACSignal *)itemViewModelSignalWithInstructionID:(NSString *)instructionID;
- (RACSignal *)itemViewModelSignalWithDWaddInstructionViewModel:(DWAddInstructionViewModel *)instructionViewModel;
- (void)presentViewController:(UIViewController *)viewControllerToPresent;
- (void)refreshData;
@end
