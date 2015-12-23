//
//  NSString+Base64.h
//  实验助手
//
//  Created by sxq on 15/10/28.
//  Copyright © 2015年 SXQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Base64)
+ (NSString*)base64forData:(NSData*)theData;
@end
