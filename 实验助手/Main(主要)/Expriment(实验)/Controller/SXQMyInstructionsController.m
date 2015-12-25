//
//  SXQMyInstructionsController.m
//  实验助手
//
//  Created by sxq on 15/9/15.
//  Copyright (c) 2015年 SXQ. All rights reserved.
//
#import "DWAddExperimentController.h"
#import "DWInstructionsHeader.h"
#import "SXQHotInstructionCell.h"
#import "DWGroup.h"
#import "SXQDBManager.h"
#import "SXQInstructionDownloadResult.h"
#import "ArrayDataSource+TableView.h"
#import "SXQMyInstructionsController.h"
#import "SXQMyInstructionCell.h"
#import "SXQInstructionManager.h"
#import "DWMyInstructionData.h"
#import "SXQReagentListController.h"
#import "SXQMyExperimentManager.h"
#import "InstructionTool.h"

@interface SXQMyInstructionsController ()
@end

@implementation SXQMyInstructionsController
- (NSArray *)groups
{
    if (_groups == nil) {
        DWMyInstructionData *instructionData = [[DWMyInstructionData alloc] init];
        instructionData.dataLoadCompletedBlk = ^{
            [self.tableView reloadData];
        };
        _groups = instructionData.groups;
    }
    return _groups;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self p_setupSelf];
}
#pragma mark - Private Method
- (void)p_setupSelf
{
    self.title = @"我的常用说明书";
    [self p_setupTableView];
}
- (void)p_setupTableView
{
    [self.tableView registerNib:[UINib nibWithNibName:@"SXQMyInstructionCell" bundle:nil] forCellReuseIdentifier:MyInstructionIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:@"SXQHotInstructionCell" bundle:nil] forCellReuseIdentifier:HotInstructionIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([DWInstructionsHeader class]) bundle:nil] forHeaderFooterViewReuseIdentifier:NSStringFromClass([DWInstructionsHeader class])];
//    _instructionsDataSource = [[ArrayDataSource alloc] initWithGroups:self.groups];
//    self.tableView.dataSource = _instructionsDataSource;
}
#pragma mark - TableView DataSource
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
    id item = group.items[indexPath.row];
    if (indexPath.section == 0) {
        SXQMyInstructionCell *cell = [tableView dequeueReusableCellWithIdentifier:MyInstructionIdentifier forIndexPath:indexPath];
        [cell configureCellForItem:item];
        return cell;
    }else
    {
        SXQHotInstructionCell *cell = [tableView dequeueReusableCellWithIdentifier:HotInstructionIdentifier forIndexPath:indexPath];
        [cell configureCellWithItem:item];
        return cell;
    }
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
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
#pragma mark tableview delegate method
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case SectionTypeHotInstructionType:
        {
            DWGroup *group = self.groups[indexPath.section];
            SXQHotInstruction *instruction = group.items[indexPath.row];
            //检查/下载说明书
            if (![SXQInstructionManager instructionIsdownload:instruction.expInstructionID]) {//还没有下载
                //下载说明书
                [InstructionTool downloadInstructionWithID:instruction.expInstructionID success:^(SXQInstructionDownloadResult *result) {
                    [SXQInstructionManager downloadInstruction:result.data completion:^(BOOL success, NSDictionary *info) {
                        
                        [self addExperimentWithExpinstructionId:instruction.expInstructionID];
                    }];
                } failure:^(NSError *error) {
                    
                }];
            }
            else{//已经下载，取出实验说明书的数据
                
                [self addExperimentWithExpinstructionId:instruction.expInstructionID];
            }
            break;
        }
        case SectionTypeMyInstructionType:
        {
            DWGroup *group = self.groups[indexPath.section];
            SXQMyGenericInstruction *genericInstruciton = group.items[indexPath.row];
            [self addExperimentWithExpinstructionId:genericInstruciton.expInstructionID];
            break;
        }           
        default:
            break;
    }

}
- (void)addExperimentWithExpinstructionId:(NSString *)expinstructionID
{
      __block SXQInstructionData *instructionData = nil;
        dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
             instructionData = [[SXQDBManager sharedManager] fetchInstuctionDataWithInstructionID:expinstructionID];
        });
        [self changeViewControllerWithInstructionData:instructionData];
}
- (void)changeViewControllerWithInstructionData:(SXQInstructionData *)instructionData
{
    
    DWAddExperimentController *addExperimentVC = [[UIStoryboard storyboardWithName:@"AddItem" bundle:nil] instantiateViewControllerWithIdentifier:NSStringFromClass([DWAddExperimentController class])];
    addExperimentVC.instructionData = instructionData;
    [self.navigationController pushViewController:addExperimentVC animated:YES];
    
}
@end












