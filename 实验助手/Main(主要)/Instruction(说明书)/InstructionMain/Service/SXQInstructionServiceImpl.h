//
//  SXQSearchServiceImpl.h
//  实验助手
//
//  Created by sxq on 15/10/29.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "SXQInstructionService.h"
#import <Foundation/Foundation.h>

@interface SXQInstructionServiceImpl : NSObject<SXQInstructionService>
- (instancetype)initWithNavigationController:(UINavigationController *)nav;
@end
