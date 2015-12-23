//
//  DWAddExpReagent.m
//  实验助手
//
//  Created by sxq on 15/12/9.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "NSString+UUID.h"
#import "DWAddExpReagent.h"
#import <MJExtension/MJExtension.h>
#import "SXQSupplier.h"
@implementation DWAddExpReagent
- (NSString *)supplierName
{
    if(!_supplierName)
    {
        _supplierName = [[_suppliers firstObject] supplierName];
        _supplierID = [[_suppliers firstObject] supplierID];
    }
    return _supplierName;
}
+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"suppliers" : [SXQSupplier class]};
}
@end
