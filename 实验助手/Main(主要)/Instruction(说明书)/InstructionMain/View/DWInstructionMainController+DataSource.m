//
//  DWInstructionMainController+DataSource.m
//  实验助手
//
//  Created by sxq on 15/11/17.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "DWInstructionCell.h"
#import "DWInstructionMainHeader.h"
#import "SXQExpCategoryViewModel.h"
#import "SXQExpSubCategory.h"
#import "DWInstructionMainController+DataSource.h"

@implementation DWInstructionMainController (DataSource)
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.expCategories.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    SXQExpCategoryViewModel *expCategory = self.expCategories[section];
    return expCategory.expSubCategories.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SXQExpCategoryViewModel *expCategory = self.expCategories[indexPath.section];
    SXQExpSubCategory *subCategory = expCategory.expSubCategories[indexPath.row];
    
    DWInstructionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([DWInstructionCell class]) forIndexPath:indexPath];
    cell.subCategory = subCategory;
    return cell;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    SXQExpCategoryViewModel *expcategory = self.expCategories[indexPath.section];
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        DWInstructionMainHeader *header = [self.collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                                                  withReuseIdentifier:NSStringFromClass([DWInstructionMainHeader class])
                                                                                         forIndexPath:indexPath];
        header.viewModel = expcategory;
        return header;
    }else if([kind isEqualToString:UICollectionElementKindSectionFooter])
    {
        UICollectionReusableView *footer = [self.collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                                                  withReuseIdentifier:NSStringFromClass([UICollectionReusableView class])
                                                                                         forIndexPath:indexPath];
        return footer;
    }
    return nil;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    const CGFloat cellWidth = [UIScreen mainScreen].bounds.size.width/3;
    return CGSizeMake(cellWidth, 44);
}
@end
