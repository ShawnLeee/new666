//
//  DWInstructionDetailController+DataSource.m
//  实验助手
//
//  Created by sxq on 15/11/16.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "DWInstructionNavViewModel.h"
#import "DWInstructionDetailHeader.h"
#import "DWInstructionDisclosure.h"
#import "SXQExpInstruction.h"
#import "SXQInstructionDetail.h"
#import "InstructionTool.h"
#import "DWGroup.h"
#import "DWInstructionDetailController+DataSource.h"
#import "DWInstructionDetailCell.h"
#import "DWInstructionDetailViewModel.h"
@implementation DWInstructionDetailController (DataSource)
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.groups.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    DWGroup *group = self.groups[section];
    return group.items.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DWGroup *group = self.groups[indexPath.section];
    if (indexPath.section == 2 || indexPath.section == 3 || indexPath.section == 4) {
        DWInstructionDetailCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DWInstructionDetailCell" forIndexPath:indexPath];
        DWInstructionDetailViewModel *viewModel = group.items[indexPath.row];
        cell.viewModel = viewModel;
        return cell;
    }else
    {
        DWInstructionDisclosure *disCell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([DWInstructionDisclosure class]) forIndexPath:indexPath];
        DWInstructionNavViewModel *viewModel = group.items[indexPath.row];
        disCell.viewModel = viewModel;
        return disCell;
    }
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    DWGroup *group = self.groups[indexPath.section];
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        DWInstructionDetailHeader *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
        [headerView.headerBtn setTitle:group.headerTitle forState:UIControlStateNormal];
        return headerView;
    }
    return nil;
}
- (void)p_loadData
{
    InstructionDetailParam *param = [InstructionDetailParam new];
    param.expInstructionID = self.instruction.expInstructionID;
    [InstructionTool fetchInstructionDetailWithParam:param success:^(InstructionDetailResult *result) {
        self.instructionDetail = result.data;
        self.groups = [self groupsWithInstructionDetail:self.instructionDetail];
        self.title = result.data.experimentName;
        [self.collectionView reloadData];
    } failure:^(NSError *error) {
        
    }];
}
- (NSArray *)groupsWithInstructionDetail:(SXQInstructionDetail *)instructionDetail
{
    DWInstructionNavViewModel *viewModel0 = [self vcModelWithTitle:instructionDetail.experimentDesc
                                                             items:nil
                                                            vcType:InstructionDetaiVcTypeText];
    viewModel0.vcTitle = @"技术简介";
    DWGroup *group0 = [DWGroup groupWithItems:@[viewModel0] identifier:@"SingleContentIdentifier"  header:@"技术简介"];
    
    DWInstructionNavViewModel *viewModel1 = [self vcModelWithTitle:instructionDetail.experimentTheory
                                                             items:nil
                                                            vcType:InstructionDetaiVcTypeText];
    viewModel1.vcTitle = @"技术原理";
    DWGroup *group1 = [DWGroup groupWithItems:@[viewModel1] identifier:@"SingleContentIdentifier" header:@"技术原理"];
    
    DWGroup *group2 = [DWGroup groupWithItems:[self convertModelToViewModel:instructionDetail.expReagents]
                                   identifier:@"SupplierIdentifier"
                                       header:@"实验试剂"];
    
    DWGroup *group3 = [DWGroup groupWithItems:[self convertModelToViewModel:instructionDetail.expConsumables]
                                   identifier:@"SupplierIdentifier"
                                       header:@"实验耗材"];
    
    DWGroup *group4 = [DWGroup groupWithItems:[self convertModelToViewModel:instructionDetail.expEquipments]
                                   identifier:@"SupplierIdentifier"
                                       header:@"实验设备"];
    
    DWInstructionNavViewModel *stepsViewModel = [self vcModelWithTitle:@"实验流程" items:instructionDetail.steps vcType:InstructionDetaiVcTypeSteps];
    DWGroup *group5 = [DWGroup groupWithItems:@[stepsViewModel] identifier:@"StepCellIdentifier" header:@"实验流程"];
    DWInstructionNavViewModel *commentViewModel = [self vcModelWithTitle:@"评论" items:instructionDetail.reviews vcType:InstructionDetaiVcTypeComment];
    DWGroup *group6 = [DWGroup groupWithItems:@[commentViewModel] identifier:@"ReviewIdentifier" header:@"评论"];
    
    NSArray *groups = @[group0,group1,group2,group3,group4,group5,group6];
    
    return groups;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    const CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    if (indexPath.section == 2 || indexPath.section == 3 || indexPath.section == 4) {
        const CGFloat cellWidth = screenWidth/3;
        return CGSizeMake(cellWidth, 44);
    }else
    {
        return CGSizeMake(screenWidth - 20, 21);
    }
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (section == 2 || section == 3 || section == 4) {
        return UIEdgeInsetsZero;
    }else
    {
        return UIEdgeInsetsMake(0, 10, 0, 10);
    }
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}
- (NSArray *)convertModelToViewModel:(NSArray *)modelArray
{
    __block NSMutableArray *viewModelArray = [NSMutableArray array];
    [modelArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        DWInstructionDetailViewModel *viewModel = [DWInstructionDetailViewModel new];
        viewModel.model = obj;
        [viewModelArray addObject:viewModel];
    }];
    return [viewModelArray copy];
}
- (DWInstructionNavViewModel *)vcModelWithTitle:(NSString *)title items:(NSArray *)items vcType:(InstructionDetaiVcType)vcType
{
    DWInstructionNavViewModel  *viewModel = [DWInstructionNavViewModel new];
    viewModel.title = title;
    viewModel.vcType = vcType;
    viewModel.items = items;
    return viewModel;
}
@end
