//
//  DWMeEditController.m
//  实验助手
//
//  Created by sxq on 15/11/25.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "MBProgressHUD+MJ.h"
#import "DWMeEditCell.h"
#import "DWMeServiceImpl.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "SXQColor.h"
#import "DWMeEditController.h"

@interface DWMeEditController ()
@property (nonatomic,strong) id<DWMeService> service;
@property (nonatomic,strong) NSArray *viewModels;
@end

@implementation DWMeEditController
- (NSArray *)viewModels
{
    if (!_viewModels) {
        _viewModels = @[];
    }
    return _viewModels;
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
    [self p_loadUserInfo];
    [self p_setupSelf];
    [self p_setupTableFooter];
}
- (void)p_setupTableView
{
    self.tableView.allowsSelection = NO;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([DWMeEditCell class])  bundle:nil] forCellReuseIdentifier:NSStringFromClass([DWMeEditCell class])];
}
- (void)p_loadUserInfo
{
    @weakify(self)
    [[self.service userInfoSignal]
    subscribeNext:^(NSArray *viewModels) {
        @strongify(self)
        self.viewModels = viewModels;
        [UIView animateWithDuration:0.5 animations:^{
            self.tableView.tableFooterView.hidden = NO;
        }];
        [self.tableView reloadData];
    }];
}
- (void)p_setupSelf
{
    self.title = @"个人信息";
}
- (void)p_setupTableFooter
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"提交" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setBackgroundColor:LABBtnBgColor];
    button.layer.cornerRadius = 6;
    button.translatesAutoresizingMaskIntoConstraints = NO;
    [self bindingButton:button];
    
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 44, 54)];
    self.tableView.tableFooterView = footer;
    self.tableView.tableFooterView.hidden = YES;
    [footer addSubview:button];
    
    [footer addConstraint:[NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:footer attribute:NSLayoutAttributeLeading multiplier:1.0 constant:10]];
    [footer addConstraint:[NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:footer attribute:NSLayoutAttributeTop multiplier:1.0 constant:10]];
    [footer addConstraint:[NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:footer attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:-10]];
    [footer addConstraint:[NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:footer attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-10]];
    
}
- (void)bindingButton:(UIButton *)button
{
    @weakify(self)
    [[[button rac_signalForControlEvents:UIControlEventTouchUpInside]
     flattenMap:^RACStream *(id value) {
         @strongify(self)
         return [self.service uploadUserProfile];
     }]
     subscribeNext:^(NSNumber *success) {
         @strongify(self)
         if ([success boolValue]) {
             [self.navigationController popViewControllerAnimated:YES];
         }
    }];
    
}
#pragma mark - TableView DataSource 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.viewModels.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DWMeEditCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([DWMeEditCell class]) forIndexPath:indexPath];
    cell.viewModel = self.viewModels[indexPath.row];
    return cell;
}
#pragma mark - TableView Delegate 
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.tableView endEditing:YES];
}
@end
