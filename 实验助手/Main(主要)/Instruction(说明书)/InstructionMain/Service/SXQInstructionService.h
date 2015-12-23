//
//  SXQSearchService.h
//  实验助手
//
//  Created by sxq on 15/10/29.
//  Copyright © 2015年 SXQ. All rights reserved.
//
@class RACSignal;
#import "SXQInstructionSearch.h"
#import <Foundation/Foundation.h>

@protocol SXQInstructionService <NSObject>
- (id<SXQInstructionSearch>)getService;
/**
 *  实验说明书首页所有分类
 *
 */
- (RACSignal *)instructionCategorySignal;
- (void)pushViewModel:(id)viewModel;
- (RACSignal *)subcategoryWithCategoryID:(NSString *)categoryId;
@end
