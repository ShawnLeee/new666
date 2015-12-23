//
//  DWAddExpInstruction.m
//  实验助手
//
//  Created by sxq on 15/12/9.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "NSString+UUID.h"
#import "Account.h"
#import "AccountTool.h"
#import "DWAddExpInstruction.h"

@implementation DWAddExpInstruction
+ (instancetype)expInstruction
{
    DWAddExpInstruction *expinstruction = [[DWAddExpInstruction alloc] init];
    expinstruction.expInstructionID = [NSString uuid];
    expinstruction.expVersion = 1;
    expinstruction.createDate = [NSString currentDate];
    expinstruction.provideUser = [[AccountTool account] userID];
    return expinstruction;
}
@end
