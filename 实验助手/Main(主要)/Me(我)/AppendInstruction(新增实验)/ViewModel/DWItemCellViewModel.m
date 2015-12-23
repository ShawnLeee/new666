//
//  DWItemCellViewModel.m
//  实验助手
//
//  Created by sxq on 15/12/11.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "DWAddExpReagent.h"
#import "DWItemCellViewModel.h"
#import "SXQSupplier.h"
#import "DWAddExpEquipment.h"
#import "DWAddExpConsumable.h"

@implementation DWItemCellViewModel
- (instancetype)initWithModel:(id)model
{
    _model = model;
    if (self = [super init]) {
        if ([model isKindOfClass:[DWAddExpReagent class]]) {
            [self p_setupWithExpReagent:model];
        }else if([model isKindOfClass:[DWAddExpEquipment class]])
        {
            [self p_setupWithExpEquipment:model];
        }else if([model isKindOfClass:[DWAddExpConsumable class]])
        {
            [self p_setupWihtExpConsumable:model];
        }
        
    }
    return self;
}
- (void)p_setupWithExpEquipment:(DWAddExpEquipment *)addExpEquipment
{
    _itemName = addExpEquipment.equipmentName;
    _supplierName = addExpEquipment.supplierName;
}
- (void)p_setupWihtExpConsumable:(DWAddExpConsumable *)addExpConsumable
{
    _itemName  = addExpConsumable.consumableName;
    _supplierName = addExpConsumable.supplierName;
}
- (void)p_setupWithExpReagent:(DWAddExpReagent *)expReagent
{
    _itemName = expReagent.reagentName;
    _supplierName = expReagent.supplierName;
}
@end
