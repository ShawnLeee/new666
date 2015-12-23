//
//  DWBBSTool.h
//  实验助手
//
//  Created by sxq on 15/12/1.
//  Copyright © 2015年 SXQ. All rights reserved.
//
@class RACSignal,DWBBSTheme,DWBBSModel,DWBBSCommentParam,DWAddThemeParam;
#import <Foundation/Foundation.h>

@protocol DWBBSTool <NSObject>
- (RACSignal *)bbsModulesSignal;
- (void)bbsPushModel:(id)model;
- (RACSignal *)themesWithBBSModel:(DWBBSModel *)bbsModel;
- (RACSignal *)commentsSignalWithBBSTheme:(DWBBSTheme *)bbsTheme;
- (RACSignal *)commentWithParam:(DWBBSCommentParam *)param;
- (RACSignal *)signalForThemeSearchWithText:(NSString *)text moduleID:(NSString *)moduleID;
- (RACSignal *)addThemeWithParam:(DWAddThemeParam *)addThemeParam;
@end
