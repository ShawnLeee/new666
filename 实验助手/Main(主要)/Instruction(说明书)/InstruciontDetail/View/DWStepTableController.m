//
//  DWStepTableController.m
//  实验助手
//
//  Created by sxq on 15/11/17.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "SXQInstructionStep.h"
#import "SXQInstructionStepCell.h"
#import "DWStepTableController.h"
#import "ArrayDataSource+TableView.h"
#import "DWInstructionStepViewModel.h"
@interface DWStepTableController ()
@property (nonatomic,strong) ArrayDataSource *stepDataSource;
@property (nonatomic,strong) id<DWInstructionService> service;
@end

@implementation DWStepTableController
- (instancetype)initWithSteps:(NSArray *)steps service:(id<DWInstructionService>)service
{
    if (self = [super init]) {
        _service = service;
        
        NSArray *viewModels = [self p_modelArrayToViewModelArray:steps];
        _stepDataSource = [[ArrayDataSource alloc] initWithItems:viewModels
                                                  cellIdentifier:NSStringFromClass([SXQInstructionStepCell class])
                                              cellConfigureBlock:^(SXQInstructionStepCell *cell, DWInstructionStepViewModel *step) {
                                                  cell.viewModel = step; }];
    }
    return self;
}
- (instancetype)initWithSteps:(NSArray *)steps
{
    if (self = [super init]) {
        NSArray *viewModels = [self p_modelArrayToViewModelArray:steps];
        _stepDataSource = [[ArrayDataSource alloc] initWithItems:viewModels
                                                  cellIdentifier:NSStringFromClass([SXQInstructionStepCell class])
                                              cellConfigureBlock:^(SXQInstructionStepCell *cell, DWInstructionStepViewModel *step) {
                                                  cell.viewModel = step; }];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self p_setupTableView];
}
- (void)p_setupTableView
{
    self.title = @"实验流程";
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.allowsSelection = NO;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SXQInstructionStepCell class]) bundle:nil]
         forCellReuseIdentifier:NSStringFromClass([SXQInstructionStepCell class])];
    self.tableView.dataSource = _stepDataSource;
}
- (NSArray *)p_modelArrayToViewModelArray:(NSArray *)modelArray
{
    __block NSMutableArray *tmpArray = [NSMutableArray array];
    [modelArray enumerateObjectsUsingBlock:^(SXQInstructionStep *step, NSUInteger idx, BOOL * _Nonnull stop) {
        DWInstructionStepViewModel *viewModel = [[DWInstructionStepViewModel alloc] initWithInstructionStep:step service:self.service];
        [tmpArray addObject:viewModel];
    }];
    return [tmpArray copy];
}
@end
