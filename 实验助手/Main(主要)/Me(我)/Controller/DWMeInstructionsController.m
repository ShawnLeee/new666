//
//  DWMeInstructionsController.m
//  实验助手
//
//  Created by sxq on 15/11/25.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "MBProgressHUD+MJ.h"
#import "DWMeInstructionCell.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "DWMeServiceImpl.h"
#import "DWMeInstructionsController.h"
#import "SXQExpInstruction.h"

@interface DWMeInstructionsController ()<DWMeInstructionCellDelegate>
@property (nonatomic,strong) id<DWMeService> service;
@property (nonatomic,strong) NSArray *instructions;
@end

@implementation DWMeInstructionsController
- (NSArray *)instructions
{
    if (!_instructions) {
        _instructions = @[];
    }
    return _instructions;
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
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([DWMeInstructionCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([DWMeInstructionCell class])];
}
- (void)p_loadMyInstructions
{
    @weakify(self)
    [[self.service allInstructionsSignal]
    subscribeNext:^(NSArray *myInstructions) {
       @strongify(self)
        self.instructions = myInstructions;
        [self.tableView reloadData];
    }];
}
#pragma mark - Table view data source
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.instructions.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DWMeInstructionCell *cell =  [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([DWMeInstructionCell class]) forIndexPath:indexPath];
    cell.delegate = self;
    cell.instruction = self.instructions[indexPath.row];
    return cell;
}
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    SXQExpInstruction *instruction = self.instructions[indexPath.row];
//    [[self.service uploadInstructionWithInstrucitonID:instruction.expInstructionID allowDownload:0]
//    subscribeNext:^(NSNumber *success) {
//        
//    }];
//}
- (void)instrucitonCell:(DWMeInstructionCell *)cell didClickedUploadButton:(UIButton *)button
{
    [self p_uploadInstructionForCell:cell share:0];
}
- (void)instrucitonCell:(DWMeInstructionCell *)cell didClickedShareButton:(UIButton *)button
{
    [self p_uploadInstructionForCell:cell share:1];
}
- (void)p_uploadInstructionForCell:(DWMeInstructionCell *)cell share:(int)share
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    if (indexPath) {
        SXQExpInstruction *instruction = self.instructions[indexPath.row];
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
          [cell close];
      }];
    }
}
@end
