//
//  DWAddExpConsumable.m
//  实验助手
//
//  Created by sxq on 15/12/9.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import <MJExtension/MJExtension.h>
#import "DWAddExpConsumable.h"
#import "SXQSupplier.h"
#import "NSString+UUID.h"

@implementation DWAddExpConsumable
+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"suppliers" : [SXQSupplier class]};
}
@end
