//
//  DWAddStepController.m
//  实验助手
//
//  Created by sxq on 15/12/15.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "MBProgressHUD+MJ.h"
#import "SXQDBManager.h"
#import "DWAddExpStep.h"
#import "DWAddStepViewModel.h"
#import "DWAddStepCell.h"
#import "DWAddStepController.h"
#import "DWAddStepFooter.h"
#import "UIBarButtonItem+SXQ.h"
#import "DWAddInstructionViewModel.h"
#import "DWAddExpInstruction.h"

@interface DWAddStepController ()
@property (nonatomic,strong) NSMutableArray *addedSteps;
@end

@implementation DWAddStepController
- (instancetype)init
{
    if (self = [super init]) {
        _addedSteps = [NSMutableArray array];
        DWAddStepViewModel *stepViewModel = [[DWAddStepViewModel alloc] initWithInstructionID:self.addInstrucitonViewModel.expInstruction.expInstructionID];
        [_addedSteps addObject:stepViewModel];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self p_setupTableView];
    [self p_setupNavigaitonBar];
    [self p_setupSteps];
}
- (void)p_setupSteps
{
    if (self.addInstrucitonViewModel.expExpStep.count) {
        [self.addedSteps removeAllObjects];
        [self.addInstrucitonViewModel.expExpStep enumerateObjectsUsingBlock:^(DWAddExpStep *expStep, NSUInteger idx, BOOL * _Nonnull stop) {
            DWAddStepViewModel *stepViewModel = [[DWAddStepViewModel alloc] initWithModel:expStep];
            [self.addedSteps addObject:stepViewModel];
        }];
    }
}
- (void)p_setupNavigaitonBar
{
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTitle:@"添加" titleColor:MainBgColor font:15 action:^{
        self.addInstrucitonViewModel.expExpStep = [self p_loadData];
        if ([self p_instructionMessageCompleted]) {
            [[SXQDBManager sharedManager] saveInstructionWithDWAddInstructionViewModel:self.addInstrucitonViewModel completion:^(BOOL success) {
                if (success) {
                    [self.navigationController popToRootViewControllerAnimated:YES];
                }else
                {
                    [MBProgressHUD showError:@"创建失败"];
                    [self.navigationController popToRootViewControllerAnimated:YES];
                }
            }];
        }
        
    }];
}
- (BOOL)p_instructionMessageCompleted
{
    DWAddInstructionViewModel *viewModel = self.addInstrucitonViewModel;
    if (viewModel.expReagent.count < 1) {
        [MBProgressHUD showError:@"请至少添加一条试剂"];
        return NO;
    }
    if (viewModel.expConsumable.count < 1) {
        [MBProgressHUD showError:@"请至少添加一条耗材"];
        return NO;
    }if (viewModel.expEquipment.count < 1) {
        [MBProgressHUD showError:@"请至少添加一条设备"];
        return NO;
    }if (viewModel.expExpStep.count < 1) {
        [MBProgressHUD showError:@"请至少添加一条步骤"];
        return NO;
    }
    return YES;
}
- (void)p_setupTableView
{
    self.title = @"添加步骤";
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 50;
    self.tableView.allowsSelection = NO;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 54, 0);
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([DWAddStepCell class]) bundle:nil]
         forCellReuseIdentifier:NSStringFromClass([DWAddStepCell class])];
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(p_dismissKeyboard:)];
    [self.view addGestureRecognizer:tapGestureRecognizer];
    [self p_setupTableFooter];
    
}
- (void)p_dismissKeyboard:(UITapGestureRecognizer *)tapReconizer
{
    [self.view endEditing:YES];
}

- (void)p_setupTableFooter
{
    typeof(self) weakSelf = self;
    DWAddStepFooter *stepFooter = [[DWAddStepFooter alloc] initWithAddHandler:^{
        DWAddStepViewModel *stepViewModel = [[DWAddStepViewModel alloc] initWithInstructionID:self.addInstrucitonViewModel.expInstruction.expInstructionID];
        [weakSelf.addedSteps addObject:stepViewModel];
        [weakSelf.tableView reloadData];
    }];
    self.tableView.tableFooterView = stepFooter;
    self.tableView.tableFooterView.frame = CGRectMake(0, 0, 300, 54);
}
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.addedSteps.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DWAddStepViewModel *stepViewModel = self.addedSteps[indexPath.row];
    stepViewModel.indexPath = indexPath;
    DWAddStepCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([DWAddStepCell class]) forIndexPath:indexPath];
    cell.tableView = self.tableView;
    cell.stepViewModel = stepViewModel;
    
    return cell;
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return NO;
    }
    return YES;
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.addedSteps removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        [self.tableView reloadData];
    }
}
- (NSArray<DWAddExpStep *> *)p_loadData
{
    __block NSMutableArray *tmpArray = [NSMutableArray array];
    [self.addedSteps enumerateObjectsUsingBlock:^(DWAddStepViewModel *stepViewModel, NSUInteger idx, BOOL * _Nonnull stop) {
        [tmpArray addObject:stepViewModel.addExpStep];
    }];
    return [tmpArray copy];
}
@end
