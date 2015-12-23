//
//  NSString+JSON.h
//  实验助手
//
//  Created by sxq on 15/12/18.
//  Copyright © 2015年 SXQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (JSON)
+ (NSString *)jsonStrWithDictionary:(NSDictionary *)dict;
@end
