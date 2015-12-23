//
//  SXQEquipment.m
//  实验助手
//
//  Created by sxq on 15/10/15.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "SXQSupplier.h"
#import <MJExtension/MJExtension.h>
#import "SXQEquipment.h"

@implementation SXQEquipment
+ (NSDictionary *)objectClassInArray
{
    return @{@"suppliers" :[SXQSupplier class] };
}
@end
