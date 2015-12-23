//
//  SXQReportServiceImpl.h
//  实验助手
//
//  Created by sxq on 15/11/10.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "SXQReportService.h"
#import <Foundation/Foundation.h>

@interface SXQReportServiceImpl : NSObject<SXQReportService>
- (instancetype)initWithNavigationController:(UINavigationController *)navigationController;
@end
