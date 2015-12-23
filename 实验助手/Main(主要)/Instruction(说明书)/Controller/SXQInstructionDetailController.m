//
//  SXQInstructionDetailController.m
//  实验助手
//
//  Created by sxq on 15/9/23.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "SXQSupplierViewModel.h"
#import "SXQReviewDetailController.h"
#import "SXQCommentCell.h"
#import "SXQSupplierCell.h"
#import "FPPopoverController.h"
#import "SXQExpReagent.h"
#import "SXQExpConsumable.h"
#import "SXQExpEquipment.h"

#import "UIBarButtonItem+MJ.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "SXQInstructionDetail.h"
#import "InstructionTool.h"
#import "ArrayDataSource+TableView.h"
#import "DWGroup.h"
#import "SXQInstructionDetailController.h"
#import "SXQExpInstruction.h"
#import "SXQInstructionStep.h"
#import "SXQInstructionStepCell.h"
#import "SXQSingleContentCell.h"
#import "SXQInstructionServiceImpl.h"
#define SupplierIdentifier @"Supplier Cell"
#define StepCellIdentifier @"Instruction Step Cell"
#define SingleContentIdentifier @"Single Content Cell"
#define ReviewIdentifier @"CommentCell"
@interface SXQInstructionDetailController ()
@property (nonatomic,strong) SXQExpInstruction *instruction;
@property (nonatomic,strong) ArrayDataSource *instructionDataSource;
@property (nonatomic,strong) NSArray *groups;
@property (nonatomic,strong) id<SXQInstructionService> service;
@property (nonatomic,strong) SXQInstructionDetail *instructionDetail;
@property (nonatomic,strong) FPPopoverController *popOver;
@end

@implementation SXQInstructionDetailController
- (id<SXQInstructionService>)service
{
    if (_service == nil) {
        _service = [[SXQInstructionServiceImpl alloc] init];
    }
    return _service;
}
- (instancetype)initWithInstruction:(SXQExpInstruction *)instruction
{
    if (self = [super initWithStyle:UITableViewStylePlain]) {
        _instruction = instruction;
        _groups = @[];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self p_setupTableView];
    [self p_loadData];
}

- (void)p_setupTableView
{
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithIcon:@"Night_ZHImageViewerSaveIcon_iOS7" highIcon:nil target:self action:@selector(saveInstruction)];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 80;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"SXQInstructionStepCell" bundle:nil] forCellReuseIdentifier:StepCellIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:@"SXQSingleContentCell" bundle:nil] forCellReuseIdentifier:SingleContentIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:@"SXQSupplierCell" bundle:nil] forCellReuseIdentifier:SupplierIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:@"SXQCommentCell" bundle:nil] forCellReuseIdentifier:ReviewIdentifier];
    _instructionDataSource = [[ArrayDataSource alloc] initWithGroups:_groups];
    self.tableView.dataSource = _instructionDataSource;
}
- (void)saveInstruction
{
#warning 是否已经修改过，已经修改过更新原来修改过的数据，未修改过插入一条新数据
    [[[[self.service getService] signalForSaveInstruction:_instructionDetail]
     deliverOnMainThread]
     subscribeNext:^(id x) {
    }];
}

- (void)p_loadData
{
    InstructionDetailParam *param = [InstructionDetailParam new];
    param.expInstructionID = _instruction.expInstructionID;
    [InstructionTool fetchInstructionDetailWithParam:param success:^(InstructionDetailResult *result) {
        _instructionDetail = result.data;
        _groups = [self groupsWithInstructionDetail:_instructionDetail];
        _instructionDataSource.items = _groups;
        self.title = result.data.experimentName;
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}
- (NSArray *)groupsWithInstructionDetail:(SXQInstructionDetail *)instructionDetail
{
    DWGroup *group0 = [DWGroup groupWithItems:@[instructionDetail.experimentDesc] identifier:SingleContentIdentifier  header:@"技术简介"];
    group0.configureBlk = ^(SXQSingleContentCell *cell,NSString *item){
        [cell configureCellWithItem:item];
    };
    DWGroup *group1 = [DWGroup groupWithItems:@[instructionDetail.experimentTheory] identifier:SingleContentIdentifier header:@"技术原理"];
    group1.configureBlk = group0.configureBlk;
    
    DWGroup *group2 = [DWGroup groupWithItems:[self convertToViewModelArrayWithModelArray:instructionDetail.expReagents] identifier:SupplierIdentifier header:@"实验试剂"];
    group2.configureBlk = ^(SXQSupplierCell *cell,SXQSupplierViewModel  *item){
        cell.viewModel = item;
    };
    
    DWGroup *group3 = [DWGroup groupWithItems:[self convertToViewModelArrayWithModelArray:instructionDetail.expConsumables] identifier:SupplierIdentifier header:@"实验耗材"];
    group3.configureBlk = ^(SXQSupplierCell *cell,SXQSupplierViewModel  *item){
        cell.viewModel = item;
    };
    
    DWGroup *group4 = [DWGroup groupWithItems:[self convertToViewModelArrayWithModelArray:instructionDetail.expEquipments] identifier:SupplierIdentifier header:@"实验设备"];
    group4.configureBlk = ^(SXQSupplierCell *cell,SXQSupplierViewModel  *item){
        cell.viewModel = item;
    };
    
    DWGroup *group5 = [DWGroup groupWithItems:instructionDetail.steps identifier:StepCellIdentifier header:@"实验流程"];
    group5.configureBlk = ^(SXQInstructionStepCell *cell,SXQInstructionStep *instrucitonStep){
        [cell configureCellWithItem:instrucitonStep];
    };
    DWGroup *group6 = [DWGroup groupWithItems:instructionDetail.reviews identifier:ReviewIdentifier header:@"评论" configureBlk:^(SXQCommentCell *cell, SXQReview *reviewItem) {
        cell.review = reviewItem;
    }];
    
    NSArray *groups = @[group0,group1,group2,group3,group4,group5,group6];
    
    return groups;
}
- (NSArray *)convertToViewModelArrayWithModelArray:(NSArray *)modelArray
{
    __block NSMutableArray *tmpArray = [[NSMutableArray alloc] init];
    [modelArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        SXQSupplierViewModel *viewModel = [[SXQSupplierViewModel alloc] init];
        if ([obj isKindOfClass:[SXQExpConsumable class]]) {
            SXQExpConsumable *consumable = (SXQExpConsumable *)obj;
            viewModel.consumableModel = consumable;
        }else if([obj isKindOfClass:[SXQExpEquipment class]])
        {
            SXQExpEquipment *equipment = (SXQExpEquipment *)obj;
            viewModel.equipmentModel = equipment;
        }else
        {
            SXQExpReagent *reagent = (SXQExpReagent *)obj;
            viewModel.reagentModel = reagent;
        }
        [tmpArray addObject:viewModel];
    }];
    return [tmpArray copy];
}
- (void)supplierCell:(SXQSupplierCell *)cell clickedBtn:(UIButton *)button
{
}

#pragma mark - TableView Delegate Method 

@end
