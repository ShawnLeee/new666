//
//  SXQSettingArrowItem.m
//  实验助手
//
//  Created by sxq on 15/11/4.
//  Copyright © 2015年 SXQ. All rights reserved.
//

#import "SXQSettingArrowItem.h"

@implementation SXQSettingArrowItem
+ (instancetype)itemWithTitle:(NSString *)title destVcClass:(Class)destVcClass
{
    SXQSettingArrowItem *item = [self itemWithTitle:title];
    item.destVcClass = destVcClass;
    return item;
}
@end
