//
//  DWInstructionDetailController.m
//  实验助手
//
//  Created by sxq on 15/11/16.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "SXQExpInstruction.h"
#import "MBProgressHUD+MJ.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "UIBarButtonItem+SXQ.h"
#import "DWInstructionDetailController+DataSource.h"
#import "DWGroup.h"
#import "DWInstructionDetailController.h"
#import "DWInstructionDetailHeader.h"
#import "DWInstructionDetailCell.h"
#import "DWInstructionDisclosure.h"
#import "DWInstructionServiceImpl.h"
@interface DWInstructionDetailController ()
@property (nonatomic,strong) id<DWInstructionService> service;
@end

@implementation DWInstructionDetailController

static NSString * const reuseIdentifier = @"cell";
- (id<DWInstructionService>)service
{
    if(!_service)
    {
        _service = [[DWInstructionServiceImpl alloc] initWithNavigationController:self.navigationController];
    }
    return _service;
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    [self p_setupNavigation];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([DWInstructionDetailCell class]) bundle:nil] forCellWithReuseIdentifier: NSStringFromClass([DWInstructionDetailCell class])];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([DWInstructionDisclosure class]) bundle:nil] forCellWithReuseIdentifier: NSStringFromClass([DWInstructionDisclosure class])];
    [self p_loadData];
}
- (void)p_setupNavigation
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 30, 21);
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [button setTitle:@"保存" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    @weakify(self)
    [[[[[button rac_signalForControlEvents:UIControlEventTouchUpInside]
      filter:^BOOL(id value) {
          if (!self.instruction.downloaded) {
              [MBProgressHUD showError:@"请先下载说明书"];
          }
          return self.instruction.downloaded;
      }]
       flattenMap:^RACStream *(id value) {
           @strongify(self)
           return [self.service signalForSaveInstruction:self.instructionDetail];
    }]
      deliverOnMainThread]
      subscribeNext:^(NSNumber *success) {
           @strongify(self)
        if ([success boolValue]) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    DWGroup *group = self.groups[indexPath.section];
    id viewModel = group.items[indexPath.row];
    [self.service pushViewModel:viewModel];
}
@end
