//
//  DWAddExpReagent.h
//  实验助手
//
//  Created by sxq on 15/12/9.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface DWAddExpReagent : NSObject
@property (nonatomic,copy) NSString *expReagentID;
@property (nonatomic,copy) NSString *expInstructionID;

@property (nonatomic,copy) NSString *levelOneSortID;
@property (nonatomic,copy) NSString *levelOneSortName;

@property (nonatomic,copy) NSString *levelTwoSortID;
@property (nonatomic,copy) NSString *levelTwoSortName;

@property (nonatomic,copy) NSString *reagentID;
@property (nonatomic,copy) NSString *reagentName;

@property (nonatomic,copy) NSString *reagentCommonName;
@property (nonatomic,copy) NSString *createMethod;
@property (nonatomic,copy) NSString *reagentSpec;
@property (nonatomic,copy) NSString *supplierID;
@property (nonatomic,copy) NSString *supplierName;

@property (nonatomic,assign) int useAmount;

@property (nonatomic,strong) NSArray *suppliers;
@end
