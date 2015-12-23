//
//  SXQExpCategory.m
//  实验助手
//
//  Created by sxq on 15/9/21.
//  Copyright (c) 2015年 SXQ. All rights reserved.
//
#import <MJExtension/MJExtension.h>
#import "SXQExpCategory.h"
#import "SXQExpSubCategory.h"
@implementation SXQExpCategory
+ (NSDictionary *)objectClassInArray
{
    return @{@"expSubCategories" :[SXQExpSubCategory class]};
}
@end
