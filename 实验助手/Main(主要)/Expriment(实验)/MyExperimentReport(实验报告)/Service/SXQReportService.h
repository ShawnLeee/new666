//
//  SXQReportService.h
//  实验助手
//
//  Created by sxq on 15/11/10.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "SXQReportHelper.h"
#import <Foundation/Foundation.h>

@protocol SXQReportService <NSObject>
- (id<SXQReportHelper>)getReportHelper;
- (void)pushViewModel:(id)viewModel;
@end
