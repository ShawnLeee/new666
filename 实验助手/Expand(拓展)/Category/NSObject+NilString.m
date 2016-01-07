//
//  NSObject+NilString.m
//  实验助手
//
//  Created by sxq on 16/1/7.
//  Copyright © 2016年 SXQ. All rights reserved.
//

#import "NSObject+NilString.h"
#import <objc/objc-runtime.h>
@implementation NSObject (NilString)
- (void)replaceNilValueForStringProper
{
    Class cls = [self class];
    unsigned int ivarsCount = 0;
    Ivar *ivars = class_copyIvarList(cls, &ivarsCount);
    for (const Ivar *p = ivars; p < ivars + ivarsCount; ++p) {
        Ivar const ivar = *p;
        //Get ivar name
        NSString *key = [NSString stringWithUTF8String:ivar_getName(ivar)];
        //Get ivar value
        id value = [self valueForKey:key];
        //Get ivar type
        const char *type = ivar_getTypeEncoding(ivar);
        NSString *typeStr = [NSString stringWithFormat:@"%s",type];
        if (!value) {
            if ([typeStr containsString:@"NSString"]) {
                [self setValue:@"" forKey:key];
            }
        }
    }
}
@end
