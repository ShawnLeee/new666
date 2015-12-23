//
//  DWAddExpEquipment.m
//  实验助手
//
//  Created by sxq on 15/12/9.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import <MJExtension/MJExtension.h>
#import "DWAddExpEquipment.h"
#import "SXQSupplier.h"
#import "NSString+UUID.h"
@implementation DWAddExpEquipment
+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"suppliers" : [SXQSupplier class]};
}
- (NSString *)supplierName
{
    if (!_supplierName) {
        _supplierName = [[self.suppliers firstObject] supplierName];
        _supplierID = [[self.suppliers firstObject] supplierID];
    }
    return _supplierName;
}
@end
