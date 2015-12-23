//
//  SXQInstructionDetail.m
//  实验助手
//
//  Created by sxq on 15/9/23.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "SXQReview.h"
#import "SXQExpConsumable.h"
#import "SXQExpEquipment.h"
#import "SXQExpReagent.h"
#import <MJExtension/MJExtension.h>
#import "SXQInstructionDetail.h"
#import "SXQInstructionStep.h"
@implementation SXQInstructionDetail
- (instancetype)init
{
    if (self = [super init]) {
        _stepSaved = NO;
        _consumableSaved = NO;
        _equipmentsSaved = NO;
        _reagentsSaved = NO;
    }
    return self;
}
+ (NSDictionary *)objectClassInArray
{
    return  @{@"steps" : [SXQInstructionStep class],@"expConsumables" :SXQExpConsumable.class,@"expReagents" : SXQExpReagent.class,@"expEquipments" : [SXQExpEquipment class] ,@"reviews" : [SXQReview class]};
}
@end
