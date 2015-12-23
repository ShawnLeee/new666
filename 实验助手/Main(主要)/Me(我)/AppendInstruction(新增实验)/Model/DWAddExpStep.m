//
//  DWAddExpStep.m
//  实验助手
//
//  Created by sxq on 15/12/9.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "NSString+UUID.h"
#import "DWAddExpStep.h"

@implementation DWAddExpStep
- (instancetype)initWithInstructionID:(NSString *)instructionID
{
    if(self = [super init])
    {
        self.expInstructionID = instructionID;
    }
    return self;
}
@end
