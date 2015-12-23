//
//  DWBBSController.m
//  实验助手
//
//  Created by sxq on 15/12/1.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "DWBBSModel.h"
#import "DWBBSModuleCell.h"
#import "DWBBSController.h"

@interface DWBBSController ()<UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong) NSArray *modules;
@end

@implementation DWBBSController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self p_loadData];
    [self p_setupCollectionView];
}
- (void)p_setupCollectionView
{
    NSString *cellIdentifer  = NSStringFromClass([DWBBSModuleCell class]);
    [self.collectionView registerNib:[UINib nibWithNibName:cellIdentifer bundle:nil] forCellWithReuseIdentifier:cellIdentifer];
    self.collectionView.backgroundColor = [UIColor whiteColor];
}
- (void)p_loadData
{
    @weakify(self)
    [[[self.service getBBSTool] bbsModulesSignal]
     subscribeNext:^(NSArray *modules) {
         @strongify(self)
         self.modules = modules;
         [self.collectionView reloadData];
     }]; 
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.modules.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DWBBSModuleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([DWBBSModuleCell class]) forIndexPath:indexPath];
    cell.bbsModel = self.modules[indexPath.row];
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat const cellWidth = [UIScreen mainScreen].bounds.size.width/3;
    return CGSizeMake(cellWidth, 44);
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [[self.service getBBSTool] bbsPushModel:self.modules[indexPath.row]];
}
@end
