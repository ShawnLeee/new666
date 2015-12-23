//
//  SXQExpReagent.m
//  实验助手
//
//  Created by sxq on 15/9/30.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "SXQSupplier.h"
#import "SXQExpReagent.h"
#import <MJExtension/MJExtension.h>
@implementation SXQExpReagent
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
