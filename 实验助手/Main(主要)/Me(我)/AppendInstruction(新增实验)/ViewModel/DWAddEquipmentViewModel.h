//
//  DWAddEquipmentViewModel.h
//  实验助手
//
//  Created by sxq on 15/12/14.
//  Copyright © 2015年 SXQ. All rights reserved.
//
@class DWAddExpEquipment;
#import <Foundation/Foundation.h>

@interface DWAddEquipmentViewModel : NSObject
@property (nonatomic,copy) NSString *equipmentName;
@property (nonatomic,copy) NSString *equipmentID;
@property (nonatomic,copy) NSString *supplierName;
@property (nonatomic,copy) NSString *supplierID;
@property (nonatomic,strong) DWAddExpEquipment *addExpEquipment;
@end
