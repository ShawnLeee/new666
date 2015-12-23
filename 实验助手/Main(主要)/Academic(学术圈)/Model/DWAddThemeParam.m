//
//  DWAddThemeParam.m
//  实验助手
//
//  Created by sxq on 15/12/4.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "Account.h"
#import "AccountTool.h"
#import "DWAddThemeParam.h"

@implementation DWAddThemeParam
- (NSString *)topicCreatorID
{
    if (!_topicCreatorID) {
        _topicCreatorID = [AccountTool account].userID;
    }
    return _topicCreatorID;
}
+ (instancetype)paramWithModuleID:(NSString *)moduleID
{
    DWAddThemeParam *param = [DWAddThemeParam new];
    param.moduleID = moduleID;
    return param;
}
@end
