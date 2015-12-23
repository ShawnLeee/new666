//
//  SXQSettingArrowItem.h
//  实验助手
//
//  Created by sxq on 15/11/4.
//  Copyright © 2015年 SXQ. All rights reserved.
//

#import "SXQSettingItem.h"

@interface SXQSettingArrowItem : SXQSettingItem
@property (nonatomic,assign) Class destVcClass;
+ (instancetype)itemWithTitle:(NSString *)title destVcClass:(Class)destVcClass;
@end
