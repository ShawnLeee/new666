//
//  SXQExpConsumable.h
//  实验助手
//
//  Created by sxq on 15/10/9.
//  Copyright © 2015年 SXQ. All rights reserved.
//
@class SXQSupplier,SXQExpConsumable;
#import <Foundation/Foundation.h>
@interface SXQExpConsumable : NSObject
@property (nonatomic,assign) int consumableCount;
@property (nonatomic,copy) NSString *consumableFactory;
@property (nonatomic,copy) NSString *myExpConsumableID;
@property (nonatomic,copy) NSString *myExpID;

@property (nonatomic,copy) NSString *consumableID;
@property (nonatomic,copy) NSString *consumableType;
@property (nonatomic,copy) NSString *expConsumableID;
@property (nonatomic,copy) NSString *expInstructionID;
@property (nonatomic,copy) NSString *consumableName;
@property (nonatomic,copy) NSString *supplierID;
@property (nonatomic,copy) NSString *supplierName;

/**
 *  所有供应商
 */
@property (nonatomic,strong) NSArray *suppliers;
/**
 *  供应商
 */
@property (nonatomic,strong) SXQSupplier *supplier;
@end
