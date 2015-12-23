//
//  DWAddReagentController.m
//  实验助手
//
//  Created by sxq on 15/12/10.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "MBProgressHUD+MJ.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "DWAddReagentCell.h"
#import "DWAddReagentViewModel.h"
#import "DWAddReagentController.h"
#import "UIBarButtonItem+SXQ.h"
#import "UIBarButtonItem+MJ.h"
#import "DWAddExpReagent.h"
#import "DWAddItemToolImpl.h"

@interface DWAddReagentController ()
@property (nonatomic,strong) DWAddReagentViewModel *reagentViewModel;
@property (nonatomic,strong) id<DWAddItemTool> addItemTool;
@property (nonatomic,strong) NSArray *reagentResutls;
@end

@implementation DWAddReagentController
- (DWAddReagentViewModel *)reagentViewModel
{
    if (!_reagentViewModel) {
        _reagentViewModel = [[DWAddReagentViewModel alloc] init];
        _reagentViewModel.expReagent = [[DWAddExpReagent alloc] init];
    }
    return _reagentViewModel;
}
- (NSArray *)reagentResutls
{
    if (!_reagentResutls) {
        _reagentResutls = [NSArray array];
    }
    return _reagentResutls;
}
- (id<DWAddItemTool>)addItemTool
{
    if (!_addItemTool) {
        _addItemTool = [DWAddItemToolImpl new];
    }
    return _addItemTool;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self p_setupTableView];
    [self p_setupNavigationBar];
    [self p_setupSearchBar];
}
#pragma mark - Private Helper Method
- (void)p_setupSearchBar
{
    @weakify(self)
    [[[[[self rac_signalForSelector:@selector(searchBar:textDidChange:) fromProtocol:@protocol(UISearchBarDelegate)]
     map:^id(RACTuple *tuple) {
         return tuple.second;
     }]
      throttle:0.6]
     flattenMap:^RACStream *(NSString *searchText) {
         return [self.addItemTool searchItemSignalWithName:searchText itemType:DWAddItemTypeReagent];
     }]
    subscribeNext:^(NSArray *searchReagents) {
        @strongify(self)
        self.reagentResutls = searchReagents;
        [self.searchDisplayController.searchResultsTableView reloadData];
    }];
}
- (void)p_setupTableView
{
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.allowsSelection = NO;
    self.tableView.estimatedRowHeight = 50;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([DWAddReagentCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([DWAddReagentCell class])];
    
    UITableView *resultsTableView = self.searchDisplayController.searchResultsTableView;
    [resultsTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
}
- (void)p_setupNavigationBar
{
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithIcon:@"Cancel_Normal" highIcon:@"Cancel_Highlight" target:self action:@selector(disMissSelf)];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTitle:@"确定" titleColor:MainBgColor font:15 action:^{
        DWAddReagentCell *cell = [[self.tableView visibleCells] firstObject];
        [cell dismissKeyBoard];
        
        if ([self p_dataValid]) {
            self.doneBlock(self.reagentViewModel.expReagent);
            [self disMissSelf];
        }
    }];
}
- (BOOL)p_dataValid
{
    if (!self.reagentViewModel.firstClass) {
        [MBProgressHUD showError:@"请选择一级分类"];
        return NO;
    }
    if(!self.reagentViewModel.secondClass)
    {
        [MBProgressHUD showError:@"请选择二级分类"];
        return NO;
        
    }
    if (!self.reagentViewModel.reagentName)
    {
        [MBProgressHUD showError:@"请填写试剂名称"];
        return NO;
    }
    if (!self.reagentViewModel.supplierName)
    {
        [MBProgressHUD showError:@"请输入供应商"];
        return NO;
    }
    return YES;
    
}
- (void)disMissSelf
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - TableView DataSource 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if ([tableView isEqual:self.searchDisplayController.searchResultsTableView]) {
        return self.reagentResutls.count;
    }
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:self.searchDisplayController.searchResultsTableView]) {
        DWAddExpReagent *addExpReagent = self.reagentResutls[indexPath.row];
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
        cell.textLabel.text = addExpReagent.reagentName;
        return cell;
    }
    DWAddReagentCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([DWAddReagentCell class]) forIndexPath:indexPath];
    cell.reagentViewModel = self.reagentViewModel;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:self.searchDisplayController.searchResultsTableView]) {
        DWAddExpReagent *expReagent = self.reagentResutls[indexPath.row];
        self.reagentViewModel.expReagent = expReagent;
        [self.tableView reloadData];
        [self.searchDisplayController setActive:NO animated:YES];
    }
}

@end
