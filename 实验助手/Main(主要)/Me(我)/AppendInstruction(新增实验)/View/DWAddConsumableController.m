//
//  DWAddConsumableController.m
//  实验助手
//
//  Created by sxq on 15/12/14.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "MBProgressHUD+MJ.h"
#import "DWAddExpConsumable.h"
#import "DWAddConsumableCell.h"
#import "DWAddConsumableController.h"
#import "UIBarButtonItem+MJ.h"
#import "UIBarButtonItem+SXQ.h"
#import "DWAddConsumabelViewModel.h"
#import "DWAddItemToolImpl.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface DWAddConsumableController ()
@property (nonatomic,strong) NSArray *searchResults;
@property (nonatomic,strong) DWAddConsumabelViewModel *consumableViewModel;
@property (nonatomic,strong) id<DWAddItemTool> addItemTool;
@end

@implementation DWAddConsumableController
- (DWAddConsumabelViewModel *)consumableViewModel
{
    if (!_consumableViewModel) {
        _consumableViewModel = [DWAddConsumabelViewModel new];
        _consumableViewModel.addExpConsumable = [DWAddExpConsumable new];
    }
    return _consumableViewModel;
}
- (id<DWAddItemTool>)addItemTool
{
    if (!_addItemTool) {
        _addItemTool = [DWAddItemToolImpl new];
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
    [self  p_setupNavigationBar];
    [self p_setupTableView];
    [self p_setupSearchBar];
}
- (void)p_setupTableView
{
    self.title = @"添加耗材";
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
        DWAddConsumableCell *cell = [[self.tableView visibleCells] firstObject];
        [cell dismissKeyboard];
        if(self.consumableViewModel.supplierName && self.consumableViewModel.consumableName)
        {
            self.doneBlock(self.consumableViewModel.addExpConsumable);
            [self disMissSelf];
        }else
        {
            [MBProgressHUD showError:@"请填写完整信息"];
        }
        
    }];
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
          return [self.addItemTool searchItemSignalWithName:searchText itemType:DWAddItemTypeConsumable];
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
        DWAddExpConsumable *addExpConsumable = self.searchResults[indexPath.row];
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
        cell.textLabel.text = addExpConsumable.consumableName;
        return cell;
    }
    DWAddConsumableCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([DWAddConsumableCell class])
                                                                forIndexPath:indexPath];
    cell.consumableViewModel = self.consumableViewModel;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:self.searchDisplayController.searchResultsTableView]) {
        DWAddExpConsumable *addExpConsumable = self.searchResults[indexPath.row];
        self.consumableViewModel.addExpConsumable = addExpConsumable;
        [self.searchDisplayController setActive:NO animated:YES];
        [self.tableView reloadData];
    }
}
@end
