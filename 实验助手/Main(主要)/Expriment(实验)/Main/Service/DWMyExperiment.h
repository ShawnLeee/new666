//
//  DWMyExperiment.h
//  实验助手
//
//  Created by sxq on 15/10/27.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
@protocol DWMyExperiment <NSObject>
- (RACSignal *)synthesizeMyExperimentWithMyExpId:(NSString *)myexpid;
- (RACSignal *)createReportWithMyExpId:(NSString *)myexpid;
@end
