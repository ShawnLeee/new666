//
//  SXQAddExpController.m
//  实验助手
//
//  Created by sxq on 15/10/9.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "DWMyExperimentServicesImpl.h"
#import "DWReagentAmountCell.h"
#import "DWReagentAmountViewModel.h"
#import "DGExperimentBaseController.h"
#import "SXQAddExpController.h"
#import "UIBarButtonItem+SXQ.h"
#import "SXQMyExperimentManager.h"
#import "SXQInstructionData.h"
#import "MBProgressHUD+MJ.h"
#import "SXQExpReagent.h"
#import "SXQReagentCountView.h"
#define countWidth ([UIScreen mainScreen].bounds.size.width - 20)
#define countHeight 40
@interface SXQAddExpController ()<UITableViewDataSource>
@property (nonatomic,strong) SXQInstructionData *instructionData;
@property (nonatomic,weak) IBOutlet UITableView *tableView;
@property (nonatomic,weak) IBOutlet NSLayoutConstraint *widthConstans;
@property (nonatomic,strong) NSArray *viewModels;
@property (nonatomic,strong) id<DWMyExperimentServices> service;
@end


@implementation SXQAddExpController
- (id<DWMyExperimentServices>)service
{
    if (!_service) {
        _service = [[DWMyExperimentServicesImpl alloc] init];
    }
    return _service;
}
- (instancetype)initWithInstructionData:(SXQInstructionData *)instructionData
{
    if (self = [super init]) {
        _instructionData = instructionData;
        _viewModels = [self.service viewModelArrayWithModelArray:instructionData.expReagent];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNav];
    [self setupTableView];
}
- (void)setupNav{
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTitle:@"确认" action:^{
       //写入数据到正在进行的实验
        [SXQMyExperimentManager addExperimentWithInstructionData:_instructionData completion:^(BOOL success,SXQExperimentModel *experiment) {
            if(success)//转到正在该实验正在进行的界面
            {
                UIViewController *rootVC = [self.navigationController.viewControllers firstObject];
                DGExperimentBaseController *currentVC = [[DGExperimentBaseController alloc] initWithExperimentModel:experiment];
                currentVC.hidesBottomBarWhenPushed = YES;
                NSArray *viewControllers = @[rootVC,currentVC];
                [self.navigationController setViewControllers:viewControllers animated:YES];
            }else
            {
                [MBProgressHUD showError:@"添加失败!"];
            }
        }];
    }];
}
- (void)setupTableView
{
    self.title = @"实验准备";
    self.tableView.allowsSelection = NO;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([DWReagentAmountCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([DWReagentAmountCell class])];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.viewModels.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DWReagentAmountCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([DWReagentAmountCell class]) forIndexPath:indexPath];
    cell.viewModel = self.viewModels[indexPath.row];
    return cell;
}
- (void)viewDidLayoutSubviews
{
    self.widthConstans.constant = ([UIScreen mainScreen].bounds.size.width - 20)/5.0;
    [self.view layoutIfNeeded];
}

@end
