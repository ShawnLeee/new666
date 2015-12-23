//
//  SXQExpEquipment.h
//  实验助手
//
//  Created by sxq on 15/10/9.
//  Copyright © 2015年 SXQ. All rights reserved.
//
@class SXQSupplier;
#import <Foundation/Foundation.h>
@interface SXQExpEquipment : NSObject
@property (nonatomic,copy)  NSString *equipmentFactory;
@property (nonatomic,copy)  NSString *myExpID;
@property (nonatomic,copy)  NSString *myExpEquipmentID;
@property (nonatomic,copy)  NSString *equipmentID;
@property (nonatomic,copy)  NSString *equipmentName;
@property (nonatomic,copy)  NSString *expEquipmentID;
@property (nonatomic,copy)  NSString *expInstructionID;
@property (nonatomic,copy)  NSString *supplierName;
@property (nonatomic,copy) NSString *supplierID;
/**
 *  所有供应商
 */
@property (nonatomic,strong) NSArray *suppliers;
/**
 *  供应商
 */
@property (nonatomic,strong) SXQSupplier *supplier;
@end
