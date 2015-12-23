//
//  DGExperimentBaseController.m
//  实验助手
//
//  Created by SXQ on 15/10/25.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "SXQSaveReagentController.h"
#import "SXQNavgationController.h"
#import "DWMyExperimentServicesImpl.h"
#import "SXQDBManager.h"
#import "DGExperimentBaseController+Signal.h"
#import "MBProgressHUD+MJ.h"
#import "CellContainerViewModel.h"
#import "SXQExperimentModel.h"
#import "SXQExperimentServices.h"
#import "SXQExperimentStepServicesImpl.h"
#import "ArrayDataSource+TableView.h"
#import "DWExperimentCell.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "SXQCurrentExperimentData.h"
//static const CGFloat height = 44;
@interface DGExperimentBaseController ()<UITableViewDelegate>
@property (nonatomic,strong) id<DWMyExperimentServices> myExperimentService;
@property (nonatomic,weak) IBOutlet UITableView  *tableView;
@property (nonatomic,weak) CellContainerViewModel *selectedViewModel;
@end

@implementation DGExperimentBaseController
- (id<DWMyExperimentServices>)myExperimentService
{
    if (_myExperimentService == nil) {
        _myExperimentService = [DWMyExperimentServicesImpl new];
    }
    return _myExperimentService;
}
- (id<SXQExperimentServices>)services
{
    if (_services == nil) {
        _services = [[SXQExperimentStepServicesImpl alloc] initWithNavigationController:self.navigationController];
    }
    return _services;
}
- (instancetype)initWithExperimentModel:(SXQExperimentModel *)experimentModel
{
    if (self = [super init]) {
        _experimentModel = experimentModel;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupProperty];
    [self p_loadData];
    [self p_setupTableviewFooter];
}
- (void)p_loadData
{
    __block MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.tableView animated:YES];
    self.tableView.tableFooterView.hidden = YES;
    [[[[[[self.services getServices] experimentStepSignalWithMyExpId:self.experimentModel.myExpID]
      deliverOn:[RACScheduler mainThreadScheduler]]
      map:^id(SXQCurrentExperimentData *experimentData) {
          return experimentData.expProcesses;
      }]
      map:^id(NSArray *expProcesses) {
         return [self modelArrayToViewModelArray:expProcesses];
      }]
      subscribeNext:^(NSArray *viewModels) {
         self.arrDataSource.items = viewModels;
         [self.tableView reloadData];
          [hud hide:YES];
          self.tableView.tableFooterView.hidden = NO;
     }]; 
}
- (void)setupProperty
{
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
    self.tableView.allowsSelection = NO;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 10, 0);
    self.title = @"实验步骤";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"DWExperimentCell" bundle:nil] forCellReuseIdentifier:@"Experiment Cell"];
    _arrDataSource = [[ArrayDataSource alloc] initWithItems:@[] cellIdentifier:@"Experiment Cell" cellConfigureBlock:^(DWExperimentCell *cell, CellContainerViewModel *viewModel) {
        cell.viewModel = viewModel;
    }];
    self.tableView.dataSource = _arrDataSource;
    self.tableView.delegate =  self;
}
- (NSArray *)modelArrayToViewModelArray:(NSArray *)modelArray
{
    __block NSMutableArray *viewModelArray = [NSMutableArray array];
    [modelArray enumerateObjectsUsingBlock:^(SXQExpStep *expStep, NSUInteger idx, BOOL * _Nonnull stop) {
        CellContainerViewModel *viewModel =  [CellContainerViewModel viewModelWithExpStep:expStep service:self.services];
        viewModel.updateCellBlock = ^{
            [self.tableView reloadData];
        };
        [viewModelArray addObject:viewModel];
    }];
    return [viewModelArray copy];
}
- (void)bindingReportBtn
{
//    [[[_toolBar.reportBtn rac_signalForControlEvents:UIControlEventTouchUpInside]
//     flattenMap:^RACStream *(id value) {
//         return [[self.myExperimentService getServices] synthesizeMyExperimentWithMyExpId:self.experimentModel.myExpID];
//     }]
//     subscribeNext:^(id x) {
//     
//    }];
}
- (void)dg_activeAllStep
{
    [self p_activeAllStep];
}
- (RACSignal *)launchSignalWithModel:(CellContainerViewModel *)viewModel
{
    @weakify(self)
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        //启动当前步骤->提示是否停止此前暂停的步骤->启动计时器->置其他计时器为不能启动状态(置当前步骤为此步)
        //暂停当前步骤->暂停计时器->确认是否暂停->是->暂停计时器(置其他步骤为可启动状态)->提示是否添加试剂保存位置->是->添加保存位置
//                                        ->否->启动计时器                    ->否->Do Nothing!
        if(viewModel.isUseTimer){//正在计时，暂停
            //暂停计时器
            viewModel.isUseTimer = NO;
            //确认是否暂停
            [self suspendTimerWithViewModel:viewModel handler:^(BOOL suspend) {
                if (suspend) {//暂停
                    viewModel.isUseTimer = NO;
                    //置所有步骤为可启动状态
                    [self p_activeAllStep];
                    //提示是否添加试剂保存位置
                    [self addReagentLocationHandler:^(BOOL add) {
                        if (add) {//添加试剂保存位置
                            @strongify(self)
                            [self addReagentLocationWithViewModel:viewModel completion:^{
                                [subscriber sendCompleted];
                            }];
                        }else
                        {
                            [subscriber sendCompleted];
                        }
                    }];
                }else
                {
                    viewModel.isUseTimer = YES;
                    [subscriber sendCompleted];
                }
            }];
        }else//没有在计时，启动计时器
        {
            //提示是否停止此前暂停的步骤
            //启动计时器
            if (viewModel.stepTime != 0) {
                viewModel.isUseTimer = YES;
                //置其他步骤为不能启动状态
                [self p_deActiveStepExceptViewModel:viewModel];
            }else
            {
                [MBProgressHUD showError:@"请选择时间"];
            }
            [subscriber sendCompleted];
        }
        
        return nil;
    }];
}
- (void)addReagentLocationWithViewModel:(CellContainerViewModel *)viewModel completion:(void (^)())completion
{
    SXQSaveReagentController *saveVC = [[SXQSaveReagentController alloc] initWithViewModel:viewModel completion:completion];
    SXQNavgationController *nav = [[SXQNavgationController alloc] initWithRootViewController:saveVC];
    [self presentViewController:nav animated:YES completion:nil];
}
- (void)suspendTimerWithViewModel:(CellContainerViewModel *)viewModel handler:(void (^)(BOOL suspend))handler
{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"暂停在此步骤" message:viewModel.stepDesc preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        handler(YES);
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        handler(NO);
    }];
    [alertVC addAction:action];
    [alertVC addAction:cancelAction];
    [self presentViewController:alertVC animated:YES completion:^{
    }];
}
- (void)addReagentLocationHandler:(void (^)(BOOL add))handler
{
    UIAlertController *remarkAlerVC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *saveReagentAction = [UIAlertAction actionWithTitle:@"添加试剂保存位置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        handler(YES);
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        handler(NO);
    }];
    [remarkAlerVC addAction:saveReagentAction];
    [remarkAlerVC addAction:cancelAction];
    [self.navigationController presentViewController:remarkAlerVC animated:YES completion:^{
    }];
}
- (void)p_activeAllStep
{
    [self.arrDataSource.items enumerateObjectsUsingBlock:^(CellContainerViewModel *viewModel, NSUInteger idx, BOOL * _Nonnull stop) {
        viewModel.startButtonActive = YES;
    }];
}
- (void)p_deActiveStepExceptViewModel:(CellContainerViewModel *)exceptionViewModel
{
    [self.arrDataSource.items enumerateObjectsUsingBlock:^(CellContainerViewModel *viewModel, NSUInteger idx, BOOL * _Nonnull stop) {
        viewModel.startButtonActive = [viewModel isEqual:exceptionViewModel];
    }];
}
/**
 *  只能启动一步，当前步骤处于暂停时其他步骤按钮可以按。
 */
#pragma mark Setup Table Footer
- (void)p_setupTableviewFooter
{
    UIButton *footBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [footBtn setTitle:@"完成" forState:UIControlStateNormal];
    footBtn.frame = CGRectMake(0, 0, self.view.frame.size.width, 44);
    [footBtn setBackgroundImage:[UIImage imageNamed:@"signup"] forState:UIControlStateNormal];
    self.tableView.tableFooterView = footBtn;
    
    [[[footBtn rac_signalForControlEvents:UIControlEventTouchUpInside]
     flattenMap:^RACStream *(id value) {
        return [self.services setCompleteWithMyExpId:self.experimentModel.myExpID];
     }]
     subscribeNext:^(NSNumber *success) {
         if ([success boolValue]) {
             [self.navigationController popViewControllerAnimated:YES];
         }else
         {
             [MBProgressHUD showError:@"操作失败!"];
         }
    }];
    self.tableView.tableFooterView.hidden = YES;
}
#pragma mark TableviewDelegate Method
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [[UIView alloc] initWithFrame:CGRectZero];
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 20;
}
@end
