//
//  DWBBSTopic.m
//  实验助手
//
//  Created by sxq on 15/12/3.
//  Copyright © 2015年 SXQ. All rights reserved.
//

#import "DWBBSTopic.h"

@implementation DWBBSTopic
- (NSString *)timeStr
{
    if (!_timeStr) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyy-MM-dd";
        NSTimeInterval timeInterval = [_createTime doubleValue]/1000;
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
        _timeStr = [formatter stringFromDate:date];
    }
    return _timeStr;
}
@end
