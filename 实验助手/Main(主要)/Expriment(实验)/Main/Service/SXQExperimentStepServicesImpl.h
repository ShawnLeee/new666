//
//  SXQExperimentStepServicesImpl.h
//  实验助手
//
//  Created by sxq on 15/10/23.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "SXQExperimentServices.h"
#import <Foundation/Foundation.h>

@interface SXQExperimentStepServicesImpl : NSObject<SXQExperimentServices>
- (instancetype)initWithNavigationController:(UINavigationController *)navigationController;
@end
