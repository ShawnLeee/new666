//
//  SXQReportServiceImpl.m
//  实验助手
//
//  Created by sxq on 15/11/10.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "SXQPdfController.h"
#import "SXQReportHelperImpl.h"
#import "SXQReportServiceImpl.h"
#import "SXQReportViewModel.h"
@interface SXQReportServiceImpl ()
@property (nonatomic,strong) id<SXQReportHelper> reportHelper;
@property (nonatomic,weak) UINavigationController *navigationController;
@end
@implementation SXQReportServiceImpl
- (instancetype)initWithNavigationController:(UINavigationController *)navigationController
{
    if (self = [super init]) {
        _navigationController = navigationController;
    }
    return self;
}
- (id<SXQReportHelper>)reportHelper
{
    if (!_reportHelper) {
        _reportHelper = [SXQReportHelperImpl new];
    }
    return _reportHelper;
}
- (id<SXQReportHelper>)getReportHelper
{
    return self.reportHelper;
}
- (void)pushViewModel:(id)viewModel
{
    id viewController;
    if ([viewModel isKindOfClass:[SXQReportViewModel class]]) {
        viewController = [[SXQPdfController alloc] initWithReportViewModel:viewModel];
    }else
    {
        
    }
    [self.navigationController pushViewController:viewController animated:YES];
}
@end
