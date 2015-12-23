//
//  DWInstructionUploadParam.m
//  实验助手
//
//  Created by sxq on 15/12/18.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import <MJExtension/MJExtension.h>
#import "DWInstructionUploadParam.h"

#import "DWAddExpStep.h"
#import "DWAddExpReagent.h"
#import "DWAddExpConsumable.h"
#import "DWAddExpEquipment.h"

@implementation DWInstructionUploadParam
+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"expStep" : [DWAddExpStep class],@"expReagent" : [DWAddExpReagent class],@"expConsumable" : [DWAddExpConsumable class],@"expEquipment" : [DWAddExpEquipment class]};
}
@end
