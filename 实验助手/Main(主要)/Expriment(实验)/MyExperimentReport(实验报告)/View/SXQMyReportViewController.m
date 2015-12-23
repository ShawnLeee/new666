//
//  SXQMyReportViewController.m
//  实验助手
//
//  Created by sxq on 15/11/10.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "SXQReportViewModel.h"
#import "SXQReportServiceImpl.h"
#import "SXQMyReportViewController.h"
#import "ArrayDataSource+TableView.h"
#import "SXQReportCell.h"

@interface SXQMyReportViewController ()
@property (nonatomic,strong) id<SXQReportService> reportService;
@property (nonatomic,strong) ArrayDataSource *reportDataSource;
@end

@implementation SXQMyReportViewController
- (id<SXQReportService>)reportService
{
    if (!_reportService) {
        _reportService = [[SXQReportServiceImpl alloc] initWithNavigationController:self.navigationController];
    }
    return _reportService;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self p_setupTableView];
    [self p_loadReportData];
}
- (void)p_setupTableView
{
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
    
    [self.tableView registerNib:[UINib nibWithNibName:[SXQReportCell cellIdentifier] bundle:nil]
         forCellReuseIdentifier:[SXQReportCell cellIdentifier]];
    _reportDataSource = [[ArrayDataSource alloc] initWithItems:nil cellIdentifier:[SXQReportCell cellIdentifier] cellConfigureBlock:^(SXQReportCell *cell, SXQReportViewModel *viewModel) {
        cell.viewModel = viewModel;
    }];
    self.tableView.dataSource = _reportDataSource;
}
- (void)p_loadReportData
{
    @weakify(self)
    [[[[self.reportService getReportHelper] reportListSignal]
     map:^id(NSArray *reportList) {
         return [self viewModelArrayWithModelArray:reportList];
     }]
     subscribeNext:^(NSArray *viewModeles) {
         @strongify(self)
         _reportDataSource.items = viewModeles;
         [self.tableView reloadData];
    } error:^(NSError *error) {
        
    }]; 
}
- (NSArray *)viewModelArrayWithModelArray:(NSArray *)modelArray
{
    __block NSMutableArray *viewModelArray = [NSMutableArray array];
    [modelArray enumerateObjectsUsingBlock:^(SXQReportItem *reportItem, NSUInteger idx, BOOL * _Nonnull stop) {
        SXQReportViewModel *viewModel = [[SXQReportViewModel alloc] initWithReportItem:reportItem service:self.reportService];
        [viewModelArray addObject:viewModel];
    }];
    return [viewModelArray copy];
}
@end
