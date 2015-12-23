//
//  DWAddExpEquipment.h
//  实验助手
//
//  Created by sxq on 15/12/9.
//  Copyright © 2015年 SXQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DWAddExpEquipment : NSObject
@property (nonatomic,copy) NSString *expEquipmentID;
@property (nonatomic,copy) NSString *expInstructionID;
@property (nonatomic,copy) NSString *equipmentID;
@property (nonatomic,copy) NSString *equipmentName;

@property (nonatomic,copy) NSString *supplierName;
@property (nonatomic,copy) NSString *supplierID;

@property (nonatomic,copy) NSString *equipmentFactory;

@property (nonatomic,strong) NSArray *suppliers;
@end
