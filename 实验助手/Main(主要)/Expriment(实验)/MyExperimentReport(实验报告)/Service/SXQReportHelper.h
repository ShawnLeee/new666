//
//  SXQReportHelper.h
//  实验助手
//
//  Created by sxq on 15/11/10.
//  Copyright © 2015年 SXQ. All rights reserved.
//
@class SXQReportItem;

#import <ReactiveCocoa/ReactiveCocoa.h>
#import <Foundation/Foundation.h>

@protocol SXQReportHelper <NSObject>
- (RACSignal *)reportListSignal;
- (RACSignal *)downloadReportSignalWithReportItem:(SXQReportItem *)reportItem;
- (RACSignal *)temporaryPdfPathSignalWithMyExpID:(NSString *)myExpID pdfName:(NSString *)pdfName;
@end
