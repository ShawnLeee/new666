//
//  DWCommentController.m
//  实验助手
//
//  Created by sxq on 15/11/23.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "DWCommentItemCell.h"
#import "DWCommentHeaderViewModel.h"
#import "DWCommentHeader.h"
#import "MBProgressHUD+MJ.h"
#import "DWDoingViewModel.h"
#import "UIBarButtonItem+SXQ.h"
#import "DWCommentViewModel.h"
#import "DWCommentController.h"
#import "DWCommentCell.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "DWDoingViewModel.h"
@interface DWCommentController ()<UITextViewDelegate,DWCommentHeaderDelegate>
@property (nonatomic,strong) DWDoingViewModel *viewModel;
@property (nonatomic,strong) id<DWDoingModelService> service;
@property (nonatomic,strong) NSArray *viewModels;
@property (nonatomic,weak) UITextView *commentView;
@property (nonatomic,copy) NSString *commentText;
@end

@implementation DWCommentController

- (instancetype)initWithViewModel:(DWDoingViewModel *)viewModel service:(id<DWDoingModelService>)service
{
    if (self = [super init]) {
        _viewModel = viewModel;
        _commentText = @"";
        _service = service;
        _viewModels = @[];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self p_loadData];
    [self p_setupSelf];
   
}
- (void)p_loadData
{
    @weakify(self)
    [[self.service commentViewModelSignalWithInstructioinID:self.viewModel.expInstructionID]
    subscribeNext:^(NSArray *viewModels) {
        @strongify(self)
        self.viewModels = viewModels;
        [self.tableView reloadData];
    }];
}
- (void)p_setNavigationItem
{
    self.title = @"评论";
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTitle:@"取消" action:^{
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTitle:@"确定" action:^{
        if ([self.commentText isEqualToString:@"请输入评论"]) {
            self.commentText = @"";
        }
        [[self.service commentWithExpinstructionID:self.viewModel.expInstructionID
                                          content:self.commentText
                                       viewModels:self.viewModels]
        subscribeNext:^(NSNumber *success) {
            if ([success boolValue]) {
                [self dismissViewControllerAnimated:YES completion:nil];
            }else
            {
                [MBProgressHUD showError:@"评论失败"];
            }
        }error:^(NSError *error) {
            
        }];
    }]; 
}
- (void)p_setupTableView
{
    self.tableView.allowsSelection = NO;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([DWCommentItemCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([DWCommentItemCell class])];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([DWCommentHeader class]) bundle:nil] forHeaderFooterViewReuseIdentifier:NSStringFromClass([DWCommentHeader class])];
    
    UITextView *footerView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 200, 100)];
   
    _commentView = footerView;
    footerView.delegate = self;
    footerView.text = @"请输入评论";
    footerView.textColor = [UIColor lightGrayColor];
    footerView.font = [UIFont systemFontOfSize:16];
    self.tableView.tableFooterView = footerView; 
}
- (void)p_setupSelf
{
    [self p_setNavigationItem];
    [self p_setupTableView];
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    DWCommentHeaderViewModel *viewModel = self.viewModels[section];
    DWCommentHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass([DWCommentHeader class])];
    header.delegate = self;
    header.viewModel = viewModel;
    return header;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.viewModels.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    DWCommentHeaderViewModel *viewModel = self.viewModels[section];
    return (viewModel.opened ? viewModel.items.count : 0);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DWCommentHeaderViewModel *headerModel = self.viewModels[indexPath.section];
    DWCommentItemCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([DWCommentItemCell class]) forIndexPath:indexPath];
    cell.viewModel = headerModel.items[indexPath.row];
    return cell;
}
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@"请输入评论"]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor]; //optional
    }
    [textView becomeFirstResponder];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@""]) {
        textView.text = @"请输入评论";
        textView.textColor = [UIColor lightGrayColor]; //optional
    }
    [textView resignFirstResponder];
}
- (void)textViewDidChange:(UITextView *)textView
{
    self.commentText = textView.text;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.tableView.tableFooterView resignFirstResponder];
}
#pragma mark - HeaderDelegate Method
- (void)commentHeaderClickedFoldBtn:(DWCommentHeader *)header
{
    [self.tableView reloadData];
}
@end
