//
//  SXQReportViewModel.m
//  实验助手
//
//  Created by sxq on 15/11/10.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "SXQReportItem.h"
#import "SXQReportViewModel.h"
@interface SXQReportViewModel ()
@property (nonatomic,strong) SXQReportItem *reportItem;
@property (nonatomic,strong) id<SXQReportService> service;
@end

@implementation SXQReportViewModel
- (instancetype)initWithReportItem:(SXQReportItem *)reportItem service:(id<SXQReportService>)service
{
    if (self = [super init]) {
        _reportItem = reportItem;
        _service = service;
        [self p_setup];
    }
    return self;
}
- (void)p_setup
{
    _downloadCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        if (_reportItem.downloaded) {
            return [self openPdfSignal];
        }else
        {
            return [self downloadReportSignal];
        }
    }];
    [self bindingModel];
}
- (void)bindingModel
{
    self.reportName = _reportItem.pdfName;
    
    [RACObserve(self.reportItem, downloaded)
     subscribeNext:^(NSNumber *downloaded) {
        if ([downloaded boolValue]) {
            self.buttonImageName = @"open";
        }else
        {
            self.buttonImageName = @"download";
        }   
    }];
    
    [[self.downloadCommand.executionSignals
      switchToLatest]
      subscribeNext:^(NSNumber *success) {
          self.reportItem.downloaded = [success boolValue];
    }];
}
- (RACSignal *)downloadReportSignal
{
    return [[self.service getReportHelper] downloadReportSignalWithReportItem:self.reportItem];
}
- (RACSignal *)openPdfSignal
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [self.service pushViewModel:self];
        [subscriber sendCompleted];
        return nil;
    }];
}
@end
