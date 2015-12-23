//
//  DWCommentGroup.m
//  实验助手
//
//  Created by sxq on 15/12/8.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import <MJExtension/MJExtension.h>
#import "DWCommentGroup.h"
#import "DWCommentItem.h"

@implementation DWCommentGroup
+ (NSDictionary *)objectClassInArray
{
    return @{@"expReviewDetailOfOpts" : [DWCommentItem class]};
}

@end
