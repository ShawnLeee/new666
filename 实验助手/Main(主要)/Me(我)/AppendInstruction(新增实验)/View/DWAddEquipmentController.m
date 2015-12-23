//
//  DWAddEquipmentController.m
//  实验助手
//
//  Created by sxq on 15/12/14.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "MBProgressHUD+MJ.h"
#import "DWAddExpEquipment.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "UIBarButtonItem+SXQ.h"
#import "UIBarButtonItem+MJ.h"
#import "DWAddEquipmentController.h"
#import "DWAddEquipmentCell.h"
#import "DWAddItemToolImpl.h"
#import "DWAddEquipmentViewModel.h"
@interface DWAddEquipmentController ()
@property (nonatomic,strong) id<DWAddItemTool> addItemTool;
@property (nonatomic,strong) NSArray *searchResults;
@property (nonatomic,strong) DWAddEquipmentViewModel *equipmentViewModel;
@end

@implementation DWAddEquipmentController
- (DWAddEquipmentViewModel *)equipmentViewModel
{
    if (!_equipmentViewModel) {
        _equipmentViewModel = [[DWAddEquipmentViewModel alloc] init];
        _equipmentViewModel.addExpEquipment = [[DWAddExpEquipment alloc] init];
    }
    return _equipmentViewModel;
}
- (id<DWAddItemTool>)addItemTool
{
    if (!_addItemTool) {
        _addItemTool = [[DWAddItemToolImpl alloc] init];
    }
    return _addItemTool;
}
- (NSArray *)searchResults
{
    if(!_searchResults) {
        _searchResults = [NSArray array];
    }
    return _searchResults;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self p_setupNavigationBar];
    [self p_setupTableView];
    [self p_setupSearchBar];
}
- (void)p_setupTableView
{
    self.title = @"添加设备";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.allowsSelection = NO;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 50;
    
    [self.searchDisplayController.searchResultsTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
}
- (void)p_setupNavigationBar
{
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithIcon:@"Cancel_Normal" highIcon:@"Cancel_Highlight" target:self action:@selector(disMissSelf)];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTitle:@"确定" titleColor:MainBgColor font:15 action:^{
        DWAddEquipmentCell *cell = [[self.tableView visibleCells] firstObject];
        [cell dismissKeyboard];
        
        if (![self p_contentValid]) {
            [MBProgressHUD showError:@"请填写完整信息"];
        }else
        {
            self.doneBlock(self.equipmentViewModel.addExpEquipment);
            [self disMissSelf];
        }
    }];
}
- (BOOL)p_contentValid
{
    return self.equipmentViewModel.equipmentName && self.equipmentViewModel.supplierName;
}
- (void)disMissSelf
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)p_setupSearchBar
{
    @weakify(self)
    [[[[[self rac_signalForSelector:@selector(searchBar:textDidChange:) fromProtocol:@protocol(UISearchBarDelegate)]
        map:^id(RACTuple *tuple) {
            return tuple.second;
        }]
       throttle:0.6]
      flattenMap:^RACStream *(NSString *searchText) {
          return [self.addItemTool searchItemSignalWithName:searchText itemType:DWAddItemTypeEquipment];
      }]
     subscribeNext:^(NSArray *searchResults) {
         @strongify(self)
         self.searchResults = searchResults;
         [self.searchDisplayController.searchResultsTableView reloadData];
     }];
}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([tableView isEqual:self.searchDisplayController.searchResultsTableView]) {
        return self.searchResults.count;
    }
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:self.searchDisplayController.searchResultsTableView]) {
        DWAddExpEquipment *addExpEquipment = self.searchResults[indexPath.row];
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
        cell.textLabel.text = addExpEquipment.equipmentName;
        return cell;
    }
    DWAddEquipmentCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([DWAddEquipmentCell class]) forIndexPath:indexPath];
    cell.equipmentViewModel = self.equipmentViewModel;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:self.searchDisplayController.searchResultsTableView]) {
        self.equipmentViewModel.addExpEquipment = self.searchResults[indexPath.row];
        [self.searchDisplayController setActive:NO animated:YES];
        [self.tableView reloadData];
    }
}
@end
