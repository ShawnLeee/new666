//
//  DWInstructionDetailViewModel.m
//  实验助手
//
//  Created by sxq on 15/11/16.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "SXQExpEquipment.h"
#import "SXQExpConsumable.h"
#import "SXQExpReagent.h"
#import "DWInstructionDetailViewModel.h"
@interface DWInstructionDetailViewModel ()
@end
@implementation DWInstructionDetailViewModel
- (void)setModel:(id)model
{
    _model = model;
    if ([model isKindOfClass:[SXQExpReagent class]]) {
        SXQExpReagent *reagent = (SXQExpReagent *)model;
        self.itemName = reagent.reagentName;
    }else if([model isKindOfClass:[SXQExpConsumable class]])
    {
        SXQExpConsumable *consumable = (SXQExpConsumable *)model;
        self.itemName = consumable.consumableName;
    }else
    {
        SXQExpEquipment *equipment = (SXQExpEquipment *)model;
        self.itemName = equipment.equipmentName;
    }
}
@end
