//
//  DGSignUpController.m
//  实验助手
//
//  Created by sxq on 15/11/18.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "MBProgressHUD+MJ.h"
#import "DWSignUpCell.h"
#import "DWSignUpHeader.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "DWSignUpServiceImpl.h"
#import "DGSignUpController.h"
#import "DWSignUpGroup.h"
#import "DWGroup.h"
#import "DWSignUpViewModel.h"
@interface DGSignUpController ()
@property (nonatomic,strong) id<DWSignUpService> service;
@property (nonatomic,strong) NSArray *groups;
@end

@implementation DGSignUpController
- (NSArray *)groups
{
    if (!_groups) {
        _groups = @[];
    }
    return _groups;
}
-(id<DWSignUpService>)service
{
    if (!_service) {
        _service = [[DWSignUpServiceImpl alloc] initWithTableView:self.tableView];
    }
    return _service;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSelf];
    [self p_loadData];
}
- (void)setupSelf
{
    self.title = @"注册";
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, 60, 30);
    button.titleLabel.textAlignment = NSTextAlignmentLeft;
    [button setTitle:@"取消" forState:UIControlStateNormal];
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    UIButton *submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [submitBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    submitBtn.frame = CGRectMake(0, 0, 60, 30);
    submitBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    [submitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [[[[submitBtn rac_signalForControlEvents:UIControlEventTouchUpInside]
      doNext:^(id x) {
          [self.tableView endEditing:YES];
      }]
     flattenMap:^RACStream *(id value) {
         return [self.service signUpWithGrouData:self.groups];
     }]
     subscribeNext:^(NSNumber *success) {
        if ([success boolValue]) {
            self.view.window.rootViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateInitialViewController];
        }else
        {
//            [MBProgressHUD showError:@"注册失败!"];
        }
    }];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:submitBtn];
    [self.tableView registerClass:[DWSignUpHeader class] forHeaderFooterViewReuseIdentifier:NSStringFromClass([DWSignUpHeader class])];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([DWSignUpCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([DWSignUpCell class])];
    self.tableView.allowsSelection = NO;
    
}
- (void)p_loadData
{
    [[self.service signUpModelsSignal]
     subscribeNext:^(NSArray *groups) {
        self.groups = groups;
        [self.tableView reloadData];
    }];
}
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
    DWSignUpViewModel *viewModel = group.items[indexPath.row];
    viewModel.service = self.service;
    DWSignUpCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([DWSignUpCell class])  forIndexPath:indexPath];
    cell.viewModel = viewModel;
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    DWSignUpHeader *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier: NSStringFromClass([DWSignUpHeader class])];
    headerView.group = self.groups[section];
    return headerView;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [[UIView alloc] initWithFrame:CGRectZero];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

@end
