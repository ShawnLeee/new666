//
//  NSString+JSON.m
//  实验助手
//
//  Created by sxq on 15/12/18.
//  Copyright © 2015年 SXQ. All rights reserved.
//

#import "NSString+JSON.h"

@implementation NSString (JSON)
+ (NSString *)jsonStrWithDictionary:(NSDictionary *)dict
{
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    if (jsonData.length > 0 && error == nil) {
        NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        return jsonStr;
    }else
    {
        return nil;
    }
    return nil;
}
@end
