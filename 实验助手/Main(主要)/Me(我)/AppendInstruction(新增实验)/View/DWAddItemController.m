//
//  DWAddItemController.m
//  实验助手
//
//  Created by sxq on 15/12/10.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "DWAddStepController.h"
#import "DWItemCell.h"
#import "DWAddItemHeader.h"
#import "DWAddInstructionViewModel.h"
#import "DWAddItemViewModel.h"
#import "DWAddItemController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "DWAddInstructionServiceImpl.h"
#import "DWAddExpInstruction.h"
#import "UIBarButtonItem+SXQ.h"
@interface DWAddItemController ()
@property (nonatomic,strong) NSArray<DWAddItemViewModel *> *itemViewModels;
@property (nonatomic,strong) id<DWAddInstructionService> service;
@end

@implementation DWAddItemController
- (id<DWAddInstructionService>)service
{
    if (!_service) {
        _service = [[DWAddInstructionServiceImpl alloc] initWithNavigationController:self.navigationController tableView:self.tableView];
    }
    return _service;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self p_setupNavigationBar];
    [self p_setupViewModel];
    [self p_setupTableView];
}
#pragma mark - Private Helper Method
- (void)p_setupNavigationBar
{
    self.title = @"创建说明书";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTitle:@"下一步" titleColor:MainBgColor font:15 action:^{
        [self loadData];
        DWAddStepController *stepVC = [[DWAddStepController alloc] init];
        stepVC.addInstrucitonViewModel = self.addInstrucitonViewModel;
        [self.navigationController pushViewController:stepVC animated:YES];
    }];
}
- (void)loadData
{
    self.addInstrucitonViewModel.expReagent = [self.itemViewModels[0] itemModels];
    self.addInstrucitonViewModel.expConsumable = [self.itemViewModels[1] itemModels];
    self.addInstrucitonViewModel.expEquipment = [self.itemViewModels[2] itemModels];
}
#pragma mark - TableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.itemViewModels.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    DWAddItemViewModel *headerModel = self.itemViewModels[section];
    return headerModel.items.count;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    DWAddItemHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass([DWAddItemHeader class])];
    header.viewModel = self.itemViewModels[section];
    return header;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    DWAddItemViewModel *headerModel = self.itemViewModels[indexPath.section];
    DWItemCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([DWItemCell class]) forIndexPath:indexPath];
    cell.viewModel = headerModel.items[indexPath.row];
    return cell;
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        DWAddItemViewModel *headerViewModel = self.itemViewModels[indexPath.section];
        [headerViewModel.items removeObjectAtIndex:indexPath.row];
        [headerViewModel.itemModels removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 20;
}
#pragma mark - Private Helper Method
- (void)p_setupTableView
{
    self.tableView.allowsSelection = NO;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([DWItemCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([DWItemCell class])];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([DWAddItemHeader class]) bundle:nil] forHeaderFooterViewReuseIdentifier:NSStringFromClass([DWAddItemHeader class])];
}
- (void)p_setupViewModel
{
    @weakify(self)
    if (_createFromModel) {
        [[self.service itemViewModelSignalWithDWaddInstructionViewModel:self.addInstrucitonViewModel]
        subscribeNext:^(NSArray *itemViewModels) {
            @strongify(self)
            self.itemViewModels = itemViewModels;
            [self.tableView reloadData];
        }];
    }else
    {
        [[self.service itemViewModelSignalWithInstructionID:self.addInstrucitonViewModel.expInstruction.expInstructionID]
        subscribeNext:^(NSArray *itemViewModels) {
            @strongify(self)
            self.itemViewModels = itemViewModels;
            [self.tableView reloadData];
        }];
    }
    
}
@end
