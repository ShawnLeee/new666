//
//  DWMeInstructionsController.m
//  实验助手
//
//  Created by sxq on 15/11/25.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "DWInstructionsHeader.h"
#import "MBProgressHUD+MJ.h"
#import "DWMyInstructionCell.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "DWMeServiceImpl.h"
#import "DWMeInstructionsController.h"
#import "SXQExpInstruction.h"
#import "DWGroup.h"

@interface DWMeInstructionsController ()
@property (nonatomic,strong) id<DWMeService> service;
@property (nonatomic,strong) NSArray *instructionGroups;
@end

@implementation DWMeInstructionsController
- (NSArray *)instructionGroups
{
    if (!_instructionGroups) {
        _instructionGroups = [NSArray array];
    }
    return _instructionGroups;
}

- (id<DWMeService>)service
{
    if (!_service) {
        _service = [[DWMeServiceImpl alloc] init];
    }
    return _service;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self p_setupTableView];
    [self p_loadMyInstructions];
}
- (void)p_setupTableView
{
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([DWMyInstructionCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([DWMyInstructionCell class])];
    [self.tableView registerNib: [UINib nibWithNibName:NSStringFromClass([DWInstructionsHeader class]) bundle:nil] forHeaderFooterViewReuseIdentifier: NSStringFromClass([DWInstructionsHeader class])];
}
- (void)p_loadMyInstructions
{
    @weakify(self)
    [[self.service allInstructionsSignal]
    subscribeNext:^(NSArray *instructionGroups) {
       @strongify(self)
        self.instructionGroups = instructionGroups;
        [self.tableView reloadData];
    }];
}
#pragma mark - Table view data source
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    DWInstructionsHeader *sectionHeader = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass([DWInstructionsHeader class])];
    sectionHeader.group = self.instructionGroups[section];
    return sectionHeader;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.instructionGroups.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    DWGroup *group = self.instructionGroups[section];
    return group.items.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DWGroup *group = self.instructionGroups[indexPath.section];
    DWMyInstructionCell *cell =  [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([DWMyInstructionCell class]) forIndexPath:indexPath];
    cell.expInstruction = group.items[indexPath.row];
    return cell;
}
- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 1)
        return nil;
    DWGroup *group = self.instructionGroups[indexPath.section];
    __weak __typeof(self)weakSelf = self;
    SXQExpInstruction *instruction = group.items[indexPath.row];
    
    UITableViewRowAction *shareAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"分享" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        if (instruction) {
            [weakSelf p_uploadInstruction:instruction share:0];
        }
    }];
    UITableViewRowAction *uploadAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"上传" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        if (instruction) {
            [weakSelf p_uploadInstruction:instruction share:1];
        }
    }];
    return @[shareAction,uploadAction];
}
- (void)p_uploadInstruction:(SXQExpInstruction *)instruction share:(int)share
{
     [[self.service uploadInstructionWithInstrucitonID:instruction.expInstructionID allowDownload:share]
      subscribeNext:^(NSNumber *success) {
          NSString *preMsg = nil;
          if (share == 0) {
              preMsg = @"上传";
          }else
          {
              preMsg = @"分享";
          }
          if ([success boolValue]) {
              NSString *successMsg = [NSString stringWithFormat:@"%@成功",preMsg];
            [MBProgressHUD showSuccess:successMsg];
          }else
          {
              NSString *failMsg = [NSString stringWithFormat:@"%@失败",preMsg];
              [MBProgressHUD showError:failMsg];
          }
      }];
}
@end
