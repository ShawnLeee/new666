//
//  SXQReagent.m
//  实验助手
//
//  Created by sxq on 15/10/15.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "SXQSupplier.h"
#import "SXQReagent.h"
#import <MJExtension/MJExtension.h>
@implementation SXQReagent
+ (NSDictionary *)objectClassInArray
{
    return @{@"suppliers" :[SXQSupplier class] };
}
@end
