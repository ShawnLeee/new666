//
//  DWInstructionService.h
//  实验助手
//
//  Created by sxq on 15/11/17.
//  Copyright © 2015年 SXQ. All rights reserved.
//
@class RACSignal,SXQExpReagent,SXQInstructionDetail,SXQReview;
#import <Foundation/Foundation.h>

@protocol DWInstructionService <NSObject>
- (void)pushViewModel:(id)viewModel;
- (RACSignal *)reagentSignalWithReagentModel:(SXQExpReagent *)reagent;
- (RACSignal *)signalForSaveInstruction:(SXQInstructionDetail *)instructionDetail;
- (RACSignal *)reviewDetailSignalWithReview:(SXQReview *)review;
@end
