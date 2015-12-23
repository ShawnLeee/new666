//
//  DWAddEquipmentViewModel.m
//  实验助手
//
//  Created by sxq on 15/12/14.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "DWAddEquipmentViewModel.h"
#import "DWAddExpEquipment.h"
#import "SXQSupplier.h"
@implementation DWAddEquipmentViewModel
- (void)setAddExpEquipment:(DWAddExpEquipment *)addExpEquipment
{
    _addExpEquipment = addExpEquipment;
    self.equipmentID = addExpEquipment.equipmentID;
    self.equipmentName = addExpEquipment.equipmentName;
    self.supplierName = addExpEquipment.supplierName;
    self.supplierID = addExpEquipment.supplierID;
    
    [self p_bingModel];
}
- (void)p_bingModel
{
    RAC(self.addExpEquipment,equipmentName) = RACObserve(self, equipmentName);
    RAC(self.addExpEquipment,equipmentID) = RACObserve(self, equipmentID);
    RAC(self.addExpEquipment,supplierName) = RACObserve(self, supplierName);
    RAC(self.addExpEquipment,supplierID) = RACObserve(self, supplierID);
}
@end
