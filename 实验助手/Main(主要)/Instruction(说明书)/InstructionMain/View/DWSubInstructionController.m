//
//  DWSubInstructionController.m
//  实验助手
//
//  Created by sxq on 15/11/18.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "SXQInstructionListController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "SXQExpSubCategory.h"
#import "DWInstructionCell.h"
#import "SXQExpCategoryViewModel.h"
#import "DWSubInstructionController.h"

@interface DWSubInstructionController ()
@property (nonatomic,strong) NSArray *subCategories;
@end

@implementation DWSubInstructionController
- (NSArray *)subCategories
{
    if (!_subCategories) {
        _subCategories = @[];
    }
    return _subCategories;
}
- (void)setViewModel:(SXQExpCategoryViewModel *)viewModel
{
    _viewModel = viewModel;
    self.title = viewModel.categoryName;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self p_loadData];
    [self p_setupCollectionView];
    
}
- (void)p_loadData
{
    @weakify(self)
    [[self.service subcategoryWithCategoryID:self.viewModel.expCategoryID]
     subscribeNext:^(NSArray *resultArray) {
         @strongify(self)
         self.subCategories = resultArray;
         [self.collectionView reloadData];
    }error:^(NSError *error) {
        
    }];
}
- (void)p_setupCollectionView
{
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([DWInstructionCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([DWInstructionCell class])];
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.subCategories.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SXQExpSubCategory *subCategory = self.subCategories[indexPath.row];
    
    DWInstructionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([DWInstructionCell class]) forIndexPath:indexPath];
    cell.subCategory = subCategory;
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    SXQInstructionListController *listVC = [SXQInstructionListController new];
    listVC.categoryItem = self.subCategories[indexPath.row];
    [self.navigationController pushViewController:listVC animated:YES];
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    const CGFloat cellWidth = [UIScreen mainScreen].bounds.size.width/3;
    return CGSizeMake(cellWidth, 44);
}
@end
