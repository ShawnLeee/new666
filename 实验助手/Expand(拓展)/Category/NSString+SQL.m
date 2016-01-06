//
//  NSString+SQL.m
//  实验助手
//
//  Created by sxq on 16/1/6.
//  Copyright © 2016年 SXQ. All rights reserved.
//

#import "NSString+SQL.h"

@implementation NSString (SQL)
- (NSString *)validating
{
    NSMutableString *tmpStr = [self mutableCopy];
    [tmpStr stringByReplacingOccurrencesOfString:@"'" withString:@"''"];
    return [tmpStr copy];
}
@end
