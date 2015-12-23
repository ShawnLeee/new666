//
//  DWAddThemeParam.h
//  实验助手
//
//  Created by sxq on 15/12/4.
//  Copyright © 2015年 SXQ. All rights reserved.
//

#import "SXQBaseParam.h"

@interface DWAddThemeParam : NSObject
@property (nonatomic,copy) NSString *moduleID;
@property (nonatomic,copy) NSString *topicName;
@property (nonatomic,copy) NSString *topicDetail;
@property (nonatomic,copy) NSString *topicCreatorID;
+ (instancetype)paramWithModuleID:(NSString *)moduleID;
@end
