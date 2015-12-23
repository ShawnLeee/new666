//
//  NSString+UUID.m
//  实验助手
//
//  Created by sxq on 15/12/9.
//  Copyright © 2015年 SXQ. All rights reserved.
//

#import "NSString+UUID.h"

@implementation NSString (UUID)
+(NSString*) uuid {
    CFUUIDRef puuid = CFUUIDCreate( nil );
    CFStringRef uuidString = CFUUIDCreateString( nil, puuid );
    NSString * result = (NSString *)CFBridgingRelease(CFStringCreateCopy( NULL, uuidString));
    NSString *resultStr = [result stringByReplacingOccurrencesOfString:@"-" withString:@""];
    CFRelease(puuid);
    CFRelease(uuidString);
    return resultStr;
}
+ (NSString *)currentDate
{
    NSDateFormatter *formmater = [NSDateFormatter new];
    formmater.dateFormat = @"yyyy-MM-dd";
    NSString *dateStr = [formmater stringFromDate:[NSDate date]];
    return dateStr;
}
@end
