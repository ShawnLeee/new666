//
//  SXQExpCategoryViewModel.h
//  实验助手
//
//  Created by sxq on 15/11/18.
//  Copyright © 2015年 SXQ. All rights reserved.
//
@class RACCommand,SXQExpCategory,DWInstructionMainHeader;
#import "SXQInstructionService.h"
#import <Foundation/Foundation.h>

@interface SXQExpCategoryViewModel : NSObject
@property (nonatomic,weak) DWInstructionMainHeader *header;

@property (nonatomic,copy) NSString *expCategoryID;
@property (nonatomic,copy) NSString *categoryName;
@property (nonatomic,strong) NSArray *expSubCategories;

@property (nonatomic,strong) RACCommand *moreCommand;
- (instancetype)initWithExpCategory:(SXQExpCategory *)expCategory service:(id<SXQInstructionService>)service;
@end
