//
//  SXQSettingItem.h
//  实验助手
//
//  Created by sxq on 15/11/4.
//  Copyright © 2015年 SXQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SXQSettingItem : NSObject
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *segueIdentifier;
+ (instancetype)itemWithTitle:(NSString *)title;
@end
