//
//  DWMyExperimentServices.h
//  实验助手
//
//  Created by sxq on 15/10/27.
//  Copyright © 2015年 SXQ. All rights reserved.
//
@class DWReagentAmountViewModel;
#import "DWMyExperiment.h"
#import <Foundation/Foundation.h>

@protocol DWMyExperimentServices <NSObject>
- (id<DWMyExperiment>)getServices;
- (RACSignal *)showSuppliersPickerWithSuppliers:(NSArray *)suppliers sender:(id)sender;
- (NSArray *)viewModelArrayWithModelArray:(NSArray *)modelArray;

- (void)updateRepeateCountWithCount:(NSString *)count exception:(DWReagentAmountViewModel *)exceptionModel;
@end
