//
//  DWMeViewController.m
//  实验助手
//
//  Created by sxq on 15/11/25.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "DWUserIcon.h"
#import "MBProgressHUD+MJ.h"
#import "DWAddInstructionViewModel.h"
#import "SXQNavgationController.h"
#import "DWInstructionModelController.h"
#import "DWAppendInstructionController.h"
#import "UIBarButtonItem+SXQ.h"
#import "DWSignOutView.h"
#import "DWMeEditController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "DWMeHeader.h"
#import "DWMeServiceImpl.h"
#import "DWMeViewController.h"
#import "DWMeCell.h"
#import "DWMeItem.h"

@interface DWMeViewController ()<DWMeHeaderDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic,strong) id<DWMeService> service;
@property (nonatomic,strong) NSArray *meItems;
@end

@implementation DWMeViewController
- (NSArray *)meItems
{
    if (!_meItems) {
        _meItems = @[];
    }
    return _meItems;
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
    [self p_loadMeItemsData];
    [self p_setupTableView];
    [self p_setupTableHeader];
    [self p_setupTableFooter];
}
- (void)p_setupTableView
{
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([DWMeCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([DWMeCell class])];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
     self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"Night_ZHNavigationBarAddIcon_iOS7" target:self action:@selector(p_appendInstruction)];
    
}
- (void)p_appendInstruction
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"新增说明书"
                                                             delegate:nil
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"创建一份",@"选择模版", nil];
    [actionSheet.rac_buttonClickedSignal subscribeNext:^(NSNumber *buttonIndex) {
        DWAppendInstructionController *appendVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]
                                                   instantiateViewControllerWithIdentifier:NSStringFromClass([DWAppendInstructionController class])];
        switch ([buttonIndex integerValue]) {
            case 0:
            {
                appendVC.createFromModel = NO;
                [self.navigationController pushViewController:appendVC animated:YES];
                break;
            }
            case 1:
            {
                DWInstructionModelController *modelVC = [[DWInstructionModelController alloc] initWithService:self.service completion:^(DWAddInstructionViewModel *addInstructionViewModel) {
                    appendVC.addInstructionViewModel = addInstructionViewModel;
                    appendVC.createFromModel = YES;
                    [self.navigationController pushViewController:appendVC animated:YES];
                }];
                SXQNavgationController *nav = [[SXQNavgationController alloc] initWithRootViewController:modelVC];
                [self presentViewController:nav animated:YES completion:nil];
                break;
            }
        }
    }];
    [actionSheet showInView:self.view];
}
- (void)p_setupTableFooter
{
    DWSignOutView *signOutView = [[DWSignOutView alloc] initWithService:self.service];
    self.tableView.tableFooterView = signOutView;
}
- (void)p_setupTableHeader
{
    DWMeHeader *meHeader = [[DWMeHeader alloc] init];
    meHeader.delegate = self;
    self.tableView.tableHeaderView = meHeader;
    [[self.service userIconSignal]
    subscribeNext:^(DWUserIcon *userIcon) {
        meHeader.userIconModel = userIcon;
    }];
}
- (void)p_loadMeItemsData
{
    @weakify(self)
    [[self.service meItemsSignal]
     subscribeNext:^(NSArray *meItems) {
         @strongify(self)
         self.meItems = meItems;
         [self.tableView reloadData];
    }];
}
#pragma mark - TableView DataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.meItems.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DWMeCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([DWMeCell class]) forIndexPath:indexPath];
    cell.meItem = self.meItems[indexPath.row];
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 10)];
    headerView.backgroundColor = [UIColor lightGrayColor];
    return headerView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footer =[[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 30)];
    footer.backgroundColor = [UIColor  clearColor];
    return footer;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 30;
}
#pragma mark - TableView Delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DWMeItem *item = self.meItems[indexPath.row];
    [self performSegueWithIdentifier:item.segueIdentifier sender:nil];
}
#pragma mark - HeaderDelegate
- (void)dw_meHeader:(DWMeHeader *)header didClickedHeaderButton:(UIButton *)button
{
    [self performSegueWithIdentifier:NSStringFromClass([DWMeEditController class]) sender:button];
}
- (void)dw_meHeader:(DWMeHeader *)header didClickedUserIcon:(UIImageView *)userIconView
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:nil cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从手机相册选择", nil];
    [actionSheet showInView:self.view];
    [[actionSheet rac_buttonClickedSignal]
     subscribeNext:^(NSNumber *buttonIndex) {
         switch ([buttonIndex integerValue]) {
             case 0:
             {
                 [self openCamera];
                 break;
             }
            case 1:
             {
                 [self openPhotoLibrary];
                 break;
             }
             default:
                 break;
         }
    }];
    [[[[[self rac_signalForSelector:@selector(imagePickerController:didFinishPickingMediaWithInfo:) fromProtocol:@protocol(UIImagePickerControllerDelegate)]
    map:^id(RACTuple *tuple) {
        UIViewController *vc = (UIViewController *)tuple.first;
        [vc dismissViewControllerAnimated:YES completion:nil];
        return tuple.second;
    }]
     map:^id(NSDictionary *info) {
        UIImage *image = info[UIImagePickerControllerOriginalImage];
        userIconView.image = image;
        return image;
     }]
     flattenMap:^RACStream *(UIImage *image) {
        //将图片上传到服务器
         return [self.service changeUserIconSignalWithUserImage:image];
     }]
    subscribeNext:^(NSNumber *success) {
        if (![success boolValue]) {
            [MBProgressHUD showError:@"上传图像失败"];
        }
    }];
}
/**
 *  打开相机
 */
- (void)openCamera
{
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:nil];
}

/**
 *  打开相册
 */
- (void)openPhotoLibrary
{
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:nil];
}

#pragma mark - 图片选择控制器的代理
@end
