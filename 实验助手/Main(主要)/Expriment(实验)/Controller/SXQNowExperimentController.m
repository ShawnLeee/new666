//
//  SXQNowExperimentController.m
//  实验助手
//
//  Created by sxq on 15/9/14.
//  Copyright (c) 2015年 SXQ. All rights reserved.
//
#import "DGExperimentBaseController.h"
#define Identifier @"cell"
#import "SXQDBManager.h"
#import "SXQNowExperimentController.h"
#import "SXQExperimentModel.h"
#import "ExperimentTool.h"
#import "SXQExperimentResult.h"
#import "DWCurrentViewModel.h"
#import "DWCurrentCell.h"
@interface SXQNowExperimentController ()
@property (nonatomic,strong) NSArray *experiments;
@end

@implementation SXQNowExperimentController
- (NSArray *)experiments
{
    if (!_experiments) {
        _experiments = @[];
    }
    return _experiments;
}
- (void)viewWillAppear:(BOOL)animated
{
   self.experiments = [[SXQDBManager sharedManager] fetchExperimentWithState:ExperimentStateDoing];
    [self.tableView reloadData];
    [super viewWillAppear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSelf];
    
}
- (void)setupSelf
{
    self.title = @"进行中";
    [self setupTableView];
}

- (void)setupTableView
{
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 50;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([DWCurrentCell class]) bundle:nil]
         forCellReuseIdentifier:NSStringFromClass([DWCurrentCell class])];
}
#pragma mark - TableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.experiments.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DWCurrentCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([DWCurrentCell class]) forIndexPath:indexPath];
    cell.currentViewModel = self.experiments[indexPath.row];
    return cell;
}
#pragma mark - TableView Delegate Method
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DWCurrentViewModel *currentViewModel = self.experiments[indexPath.row];
    
    SXQExperimentModel *experiment = [[SXQExperimentModel alloc] init];
    experiment.myExpID = currentViewModel.myExpID;
    
    DGExperimentBaseController *stepVC = [[DGExperimentBaseController alloc] initWithExperimentModel:experiment];
    [self.navigationController pushViewController:stepVC animated:YES];
}

@end
