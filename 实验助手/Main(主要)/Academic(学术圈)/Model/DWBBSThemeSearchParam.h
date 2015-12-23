//
//  DWBBSThemeSearchParam.h
//  实验助手
//
//  Created by sxq on 15/12/3.
//  Copyright © 2015年 SXQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DWBBSThemeSearchParam : NSObject
@property (nonatomic,copy) NSString *moduleID;
@property (nonatomic,copy) NSString *searchString;
@property (nonatomic,copy) NSString *lastTopicID;
+ (instancetype)paramWithModuleID:(NSString *)moduleID searchStr:(NSString *)searchStr;
@end
