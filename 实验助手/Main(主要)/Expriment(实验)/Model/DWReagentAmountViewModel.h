//
//  DWReagentAmountViewModel.h
//  实验助手
//
//  Created by sxq on 15/11/20.
//  Copyright © 2015年 SXQ. All rights reserved.
//
@class SXQExpReagent;
#import "DWMyExperimentServices.h"
#import <Foundation/Foundation.h>

@interface DWReagentAmountViewModel : NSObject
@property (nonatomic,strong) id<DWMyExperimentServices> service;
@property (nonatomic,copy) NSString *reagentName;
@property (nonatomic,copy) NSString *singleAmount;
@property (nonatomic,copy) NSString *sampleAmount;
@property (nonatomic,copy) NSString *repeatCount;
@property (nonatomic,copy) NSString *totalAmount;
- (instancetype)initWithReagent:(SXQExpReagent *)reagent;
@end
