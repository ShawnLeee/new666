//
//  SXQReagentListController.m
//  实验助手
//
//  Created by sxq on 15/9/30.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "DWInstructionsHeader.h"
#import "SXQSupplierViewModel.h"
#import "SXQExpEquipment.h"
#import "SXQExpConsumable.h"
#import "DWGroup.h"
#import "SXQAddExpController.h"
#import "UIBarButtonItem+SXQ.h"
#import "FPPopoverController.h"
#import "SXQReagentListData.h"
#import "ArrayDataSource+TableView.h"
#import "SXQReagentListController.h"
#import "SXQExpReagent.h"
#import "SXQReagentCell.h"
#import "SXQSupplier.h"
#import "SXQHotInstruction.h"
#import "SXQMyGenericInstruction.h"
#import "SXQInstructionData.h"
#import "SXQSupplierCell.h"
#import "DWMyExperimentServicesImpl.h"
#import "SXQSupplierProtocol.h"

#define ReagentCellIdentifier @"Reagent Cell"
#define SupplierCellIdentifier @"Supplier Cell"
@interface SXQReagentListController ()
@property (nonatomic,strong) id instruction;
@property (nonatomic,strong) ArrayDataSource *reagentDataSource;
@property (nonatomic,strong) SXQReagentListData *reagentData;
@property (nonatomic,strong) SXQInstructionData *instructionData;
@property (nonatomic,weak) UIViewController *addVC;
@property (nonatomic,strong) id<DWMyExperimentServices> service;
@property (nonatomic,strong) NSArray *groups;
@end

@implementation SXQReagentListController
- (NSArray *)groups
{
    if (!_groups) {
        _groups = @[];
    }
    return _groups;
}
- (id<DWMyExperimentServices>)service
{
    if (!_service) {
        return [DWMyExperimentServicesImpl new];
    }
    return _service;
}
- (instancetype)initWithExpInstructionData:(SXQInstructionData *)instructionData
{
    if (self = [super init]) {
        _instructionData = instructionData;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self p_setupTableView];
    [self setupNav];
}
- (void)p_setupTableView
{
    [self.tableView registerNib:[UINib nibWithNibName:@"SXQReagentCell" bundle:nil] forCellReuseIdentifier:ReagentCellIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:@"SXQSupplierCell" bundle:nil] forCellReuseIdentifier:SupplierCellIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([DWInstructionsHeader class]) bundle:nil] forHeaderFooterViewReuseIdentifier:NSStringFromClass([DWInstructionsHeader class])];

    [self setupTableDataSource];
}
- (void)setupTableDataSource
{
    DWGroup *group1 = [DWGroup groupWithItems: [self viewModelArrayWithModelArray:_instructionData.expReagent] identifier:SupplierCellIdentifier header:@"试剂厂商" configureBlk:^(SXQSupplierCell *cell,SXQSupplierViewModel  *viewModel) {
        cell.viewModel = viewModel;
    }];
    DWGroup *group2 = [DWGroup groupWithItems:[self viewModelArrayWithModelArray:_instructionData.expConsumable] identifier:SupplierCellIdentifier header:@"耗材厂商" configureBlk:^(SXQSupplierCell *cell,SXQSupplierViewModel  *viewModel ) {
        cell.viewModel = viewModel;
    }];
    DWGroup *group3 = [DWGroup groupWithItems:[self viewModelArrayWithModelArray:_instructionData.expEquipment] identifier:SupplierCellIdentifier header:@"设备厂商" configureBlk:^(SXQSupplierCell *cell,SXQSupplierViewModel  *viewModel) {
        cell.viewModel = viewModel;
    }];
    self.groups = @[group1,group2,group3];
    [self.tableView reloadData];
}
- (SXQExpReagent *)reagentForCell:(SXQReagentCell *)cell
{
    NSIndexPath *indexpath = [self.tableView indexPathForCell:cell];
    return _reagentData.reagents[indexpath.row];
}

#pragma mark setupNav
- (void)setupNav
{
    __block __weak typeof(self) weakSelf = self;
    self.title = @"实验准备";
    UIBarButtonItem *rightBarButton = [UIBarButtonItem itemWithTitle:@"下一步" action:^{
        if (weakSelf.addVC) {
            [weakSelf.navigationController pushViewController:_addVC animated:YES];
        }else
        {
            SXQAddExpController *addExpController = [[SXQAddExpController alloc] initWithInstructionData:_instructionData];
            weakSelf.addVC = addExpController;
            [weakSelf.navigationController pushViewController:addExpController animated:YES];
        }
        
    }];
    self.navigationItem.rightBarButtonItem = rightBarButton;
}
- (NSArray *)viewModelArrayWithModelArray:(NSArray *)modelArray
{
    NSMutableArray *tmpArray = [NSMutableArray array];
    [modelArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        SXQSupplierViewModel *viewModel = [[SXQSupplierViewModel alloc] initWithModel:obj];
        viewModel.service = self.service;
        [tmpArray addObject:viewModel];
    }];
    return [tmpArray copy];
    
}
#pragma mark - TableViewDataSource 
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.groups.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    DWGroup *group = self.groups[section];
    return group.items.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DWGroup *group = self.groups[indexPath.section];
    SXQSupplierCell *cell = [tableView dequeueReusableCellWithIdentifier:SupplierCellIdentifier forIndexPath:indexPath];
    cell.viewModel = group.items[indexPath.row];
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    DWGroup *group = self.groups[section];
    DWInstructionsHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass([DWInstructionsHeader class])];
    header.group = group;
    return header;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}
@end
