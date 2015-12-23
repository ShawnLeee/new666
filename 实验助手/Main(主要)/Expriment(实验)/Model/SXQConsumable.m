//
//  SXQConsumable.m
//  实验助手
//
//  Created by sxq on 15/10/15.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import <MJExtension/MJExtension.h>
#import "SXQConsumable.h"
#import "SXQSupplier.h"

@implementation SXQConsumable
+ (NSDictionary *)objectClassInArray
{
    return @{@"suppliers" :[SXQSupplier class] };
}
@end
