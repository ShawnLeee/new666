//
//  DWSignUpGroup.m
//  实验助手
//
//  Created by sxq on 15/11/18.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import <MJExtension/MJExtension.h>
#import "DWSignUpGroup.h"
#import "DWSignUpViewModel.h"
@implementation DWSignUpGroup
+ (NSDictionary *)objectClassInArray
{
    return @{@"require" :[DWSignUpViewModel class],@"optional" : [DWSignUpViewModel class] };
}
@end
