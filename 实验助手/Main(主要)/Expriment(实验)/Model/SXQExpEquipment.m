//
//  SXQExpEquipment.m
//  实验助手
//
//  Created by sxq on 15/10/9.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "SXQSupplier.h"
#import "SXQExpEquipment.h"
#import <MJExtension/MJExtension.h>
@implementation SXQExpEquipment
+ (NSDictionary *)objectClassInArray
{
    return @{@"suppliers" : [SXQSupplier class]};
}
- (SXQSupplier *)supplier
{
    if (!_supplier) {
        return [self.suppliers firstObject];
    }
    return _supplier;
}
@end
