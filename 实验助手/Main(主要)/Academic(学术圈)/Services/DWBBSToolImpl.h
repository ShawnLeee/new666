//
//  DWBBSToolImpl.h
//  实验助手
//
//  Created by sxq on 15/12/1.
//  Copyright © 2015年 SXQ. All rights reserved.
//
@class UINavigationController;
#import "DWBBSTool.h"
#import <Foundation/Foundation.h>

@interface DWBBSToolImpl : NSObject<DWBBSTool>
- (instancetype)initWithNavigationController:(UINavigationController *)navigationController;
@end
