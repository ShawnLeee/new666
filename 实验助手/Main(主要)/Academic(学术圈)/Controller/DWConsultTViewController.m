//
//  DWConsultTViewController.m
//  DWContainerViewController
//
//  Created by sxq on 15/9/17.
//  Copyright (c) 2015年 sxq. All rights reserved.
//
#import "DWConsultDetailController.h"
#import "DWAcademicServiceImpl.h"
#import "ArrayDataSource+TableView.h"
#import "DWConsultTViewController.h"
#import "DWNews.h"

@interface DWConsultTViewController ()
@property (nonatomic,strong) id<DWAcademicService> service;
@property (nonatomic,strong) ArrayDataSource *arrayDataSource;
@end

@implementation DWConsultTViewController
- (id<DWAcademicService>)service
{
    if (_service == nil) {
        _service = [DWAcademicServiceImpl new];
    }
    return _service;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self p_setupTableView];
    [self binding];
}
- (void)binding
{
    @weakify(self)
    [[[self.service getService] newsSignal]
    subscribeNext:^(NSArray *newsArray) {
        @strongify(self)
        self.arrayDataSource.items = newsArray;
        [self.tableView reloadData];
    }];
}
- (void)p_setupTableView
{
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"cell"];
    _arrayDataSource = [[ArrayDataSource alloc] initWithItems:nil cellIdentifier:@"cell" cellConfigureBlock:^(UITableViewCell *cell, DWNews *newsItem) {
        cell.textLabel.text = newsItem.content;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }];
    self.tableView.dataSource = _arrayDataSource;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    DWNews *news = self.arrayDataSource.items[indexPath.row];
    DWConsultDetailController *detailVC = [[DWConsultDetailController alloc] initWithNews:news];
    [self.parentVC.navigationController pushViewController:detailVC animated:YES];
//    [self.navigationController pushViewController:detailVC animated:YES];
//    [self presentViewController:detailVC animated:YES completion:nil];
}
@end
