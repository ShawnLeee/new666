//
//  DGExperimentConclusionController.m
//  实验助手
//
//  Created by sxq on 16/1/8.
//  Copyright © 2016年 SXQ. All rights reserved.
//
#import "DGConclusionCell.h"
#import "SXQExperimentModel.h"
#import "DGExperimentConclusionController.h"
#import "MBProgressHUD+MJ.h"
#import "DGConclusionViewModel.h"

@interface DGExperimentConclusionController ()
@property (nonatomic,strong) SXQExperimentModel *experimentModel;
@property (nonatomic,strong) id<SXQExperimentServices> service;
@property (nonatomic,strong) DGConclusionViewModel *conclusionViewModel;
@end

@implementation DGExperimentConclusionController
- (instancetype)initWithExperimentModel:(SXQExperimentModel *)experimentModel service:(id<SXQExperimentServices>)service
{
    if (self = [super init]) {
        _experimentModel = experimentModel;
        _service = service;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self p_setupConclusionData];
    [self p_setupTableView];
    [self p_setNav];
    [self p_addTapGesture];
}
- (void)p_addTapGesture
{
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(p_handleTapGesture:)];
    [self.view addGestureRecognizer:tapGesture];
}
- (void)p_handleTapGesture:(UITapGestureRecognizer *)tapGesture
{
    [self.view endEditing:YES];
}
- (void)p_setupConclusionData
{
    self.conclusionViewModel = [[DGConclusionViewModel alloc] initWithService:self.service];
    __weak __typeof(self)weakSelf = self;
    self.conclusionViewModel.updateUIBlock = ^(){
        [weakSelf.tableView reloadData];
    };
    
}
- (void)p_setNav
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitleColor:MainBgColor forState:UIControlStateNormal];
    [button setTitle:@"确定" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    button.frame = CGRectMake(0, 0, 40, 30);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    @weakify(self)
    [[[[button rac_signalForControlEvents:UIControlEventTouchUpInside]
      flattenMap:^RACStream *(id value) {
          @strongify(self)
          return [self.service saveExperimentResultWithMyExpID:self.experimentModel.myExpID conclusionViewModel:self.conclusionViewModel];
      }]
     flattenMap:^RACStream *(id value) {
          @strongify(self)
        return [self.service setCompleteWithMyExpId:self.experimentModel.myExpID];
     }]
     subscribeNext:^(NSNumber *success) {
          @strongify(self)
         if ([success boolValue]) {
             [self.navigationController popToRootViewControllerAnimated:YES];
         }else
         {
             [MBProgressHUD showError:@"操作失败!"];
         }
    }];
}
- (void)p_setupTableView
{
    self.title = @"实验结论";
    self.tableView.allowsSelection = NO;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 50;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([DGConclusionCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([DGConclusionCell class])];
}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DGConclusionCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([DGConclusionCell class]) forIndexPath:indexPath];
    cell.viewModel = self.conclusionViewModel;
    self.conclusionViewModel.cell = cell;
    self.conclusionViewModel.expInstructionID = self.experimentModel.expInstructionID;
    return cell;
}
@end
