//
//  DWBBSTopicResult.m
//  实验助手
//
//  Created by sxq on 15/12/3.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "DWBBSComment.h"
#import "DWBBSTopicResult.h"
#import <MJExtension/MJExtension.h>

@implementation DWBBSTopicResult
+ (NSDictionary *)objectClassInArray
{
    return @{@"reviews" : [DWBBSComment class]};
}
@end
