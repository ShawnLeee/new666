//
//  SXQReportViewModel.h
//  实验助手
//
//  Created by sxq on 15/11/10.
//  Copyright © 2015年 SXQ. All rights reserved.
//
@class SXQReportItem,RACCommand;
#import "SXQReportService.h"
#import <Foundation/Foundation.h>

@interface SXQReportViewModel : NSObject
@property (nonatomic,copy) NSString *reportName;
@property (nonatomic,copy) NSString *buttonImageName;
@property (nonatomic,strong) RACCommand *downloadCommand;

- (instancetype)initWithReportItem:(SXQReportItem *)reportItem service:(id<SXQReportService>)service;
@end
