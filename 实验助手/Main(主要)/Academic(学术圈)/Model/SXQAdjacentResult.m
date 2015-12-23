//
//  SXQAdjacentResult.m
//  实验助手
//
//  Created by sxq on 15/12/3.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import <MJExtension/MJExtension.h>
#import "SXQAdjacentResult.h"
#import "SXQAdjacentUser.h"
@implementation SXQAdjacentResult
+ (NSDictionary *)objectClassInArray
{
    return @{@"arounds" :[SXQAdjacentUser class]};
}
@end
