//
//  DWReagentOption.m
//  实验助手
//
//  Created by sxq on 15/12/11.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "NSString+UUID.h"
#import "DWReagentOption.h"

@implementation DWReagentOption
+ (instancetype)reagentOption
{
    DWReagentOption *reagentOption = [DWReagentOption new];
    reagentOption.reagentName = nil;
    reagentOption.reagentID = [NSString uuid];
    return reagentOption;
}
@end
