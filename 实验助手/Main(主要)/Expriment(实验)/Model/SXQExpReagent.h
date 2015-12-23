//
//  SXQExpReagent.h
//  实验助手
//
//  Created by sxq on 15/9/30.
//  Copyright © 2015年 SXQ. All rights reserved.
//
@class SXQSupplier;
#import <Foundation/Foundation.h>

@interface SXQExpReagent : NSObject
@property (nonatomic,copy) NSString *myExpID;
@property (nonatomic,copy) NSString *myExpReagentID;
@property (nonatomic,copy) NSString *expReagentID;
@property (nonatomic,copy) NSString *expInstructionID;
@property (nonatomic,copy) NSString *reagentID;
@property (nonatomic,copy) NSString *reagentName;
@property (nonatomic,copy) NSString *reagentCommonName;
@property (nonatomic,copy) NSString *reagentSpec;
@property (nonatomic,assign) int useAmount;
@property (nonatomic,copy) NSString *createMethod;

@property (nonatomic,copy) NSString *supplierID;

@property (nonatomic,copy) NSString * levelOneSortID;
@property (nonatomic,copy) NSString *levelOneSortName;
@property (nonatomic,copy) NSString * levelTwoSortID;
@property (nonatomic,copy) NSString *levelTwoSortName;
@property (nonatomic,copy) NSString * supplierName;
/**
 *   所有供应商
 */
@property (nonatomic,strong) NSArray *suppliers;
/**
 *  供应商
 */
@property (nonatomic,strong) SXQSupplier *supplier;
/**
 *  试剂总量
 */
@property (nonatomic,assign) double totalCount;
@end
