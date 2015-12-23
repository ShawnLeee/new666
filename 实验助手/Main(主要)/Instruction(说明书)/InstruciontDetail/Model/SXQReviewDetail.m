//
//  SXQReviewDetail.m
//  实验助手
//
//  Created by sxq on 15/11/9.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import <MJExtension/MJExtension.h>
#import "SXQReviewDetail.h"
#import "SXQReviewItem.h"
@implementation SXQReviewDetail
+ (NSDictionary *)objectClassInArray
{
    return @{@"reviewOpts" :[SXQReviewItem class]};
}
@end
