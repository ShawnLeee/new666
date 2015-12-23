//
//  DWInstructionServiceImpl.h
//  实验助手
//
//  Created by sxq on 15/11/17.
//  Copyright © 2015年 SXQ. All rights reserved.
//
@class UINavigationController;
#import "DWInstructionService.h"
#import <Foundation/Foundation.h>

@interface DWInstructionServiceImpl : NSObject<DWInstructionService>
- (instancetype)initWithNavigationController:(UINavigationController *)nav;
@end
