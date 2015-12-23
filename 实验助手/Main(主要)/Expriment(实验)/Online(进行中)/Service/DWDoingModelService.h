//
//  DWDoingModelService.h
//  实验助手
//
//  Created by sxq on 15/11/13.
//  Copyright © 2015年 SXQ. All rights reserved.
//
@class RACSignal,DWDoingViewModel;
#import "DWDoingViewModelTool.h"
#import <Foundation/Foundation.h>

@protocol DWDoingModelService <NSObject>
- (id<DWDoingViewModelTool>)getService;
- (RACSignal *)dw_reloadData;
- (void)presentCommentControllerWithViewModel:(DWDoingViewModel *)viewModel;
- (void)presentReportWithMyExpId:(NSString *)myexpId;
- (RACSignal *)commentViewModelSignal;
- (RACSignal *)commentWithExpinstructionID:(NSString *)expInstructionID content:(NSString *)content viewModels:(NSArray *)viewModels;
- (RACSignal *)commentViewModelSignalWithInstructioinID:(NSString *)instructionID;

- (RACSignal *)pdfURLSignalWithMyExpID:(NSString *)myExpID;
@end
