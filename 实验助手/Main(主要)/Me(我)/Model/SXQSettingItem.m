//
//  SXQSettingItem.m
//  实验助手
//
//  Created by sxq on 15/11/4.
//  Copyright © 2015年 SXQ. All rights reserved.
//

#import "SXQSettingItem.h"

@implementation SXQSettingItem
+ (instancetype)itemWithTitle:(NSString *)title
{
    SXQSettingItem *item = [[SXQSettingItem alloc] init];
    item.title = title;
    return item;
}
@end
