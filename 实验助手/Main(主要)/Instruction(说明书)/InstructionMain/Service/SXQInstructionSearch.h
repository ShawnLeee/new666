//
//  SXQInstructionSearch.h
//  实验助手
//
//  Created by sxq on 15/10/29.
//  Copyright © 2015年 SXQ. All rights reserved.
//
@class SXQInstructionDetail,SXQReview;
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <Foundation/Foundation.h>

@protocol SXQInstructionSearch <NSObject>
- (RACSignal *)signalForSerchWithText:(NSString *)text;
- (RACSignal *)signalForSaveInstruction:(SXQInstructionDetail *)instructionDetail;
- (RACSignal *)reviewDetailSignalWithReview:(SXQReview *)review;
@end
