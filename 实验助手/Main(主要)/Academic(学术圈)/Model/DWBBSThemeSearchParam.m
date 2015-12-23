//
//  DWBBSThemeSearchParam.m
//  实验助手
//
//  Created by sxq on 15/12/3.
//  Copyright © 2015年 SXQ. All rights reserved.
//

#import "DWBBSThemeSearchParam.h"

@implementation DWBBSThemeSearchParam
+ (instancetype)paramWithModuleID:(NSString *)moduleID searchStr:(NSString *)searchStr
{
    DWBBSThemeSearchParam *param = [DWBBSThemeSearchParam new];
    param.moduleID = moduleID;
    param.searchString = searchStr;
    return param;
}
@end
