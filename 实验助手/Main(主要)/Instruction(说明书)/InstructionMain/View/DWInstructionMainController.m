//
//  DWInstructionMainController.m
//  实验助手
//
//  Created by sxq on 15/11/17.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "SXQColor.h"
#import "SXQExpCategory.h"
#import "SXQInstructionListController.h"
#import "SXQInstructionServiceImpl.h"
#import "DWInstructionMainController.h"
#import "DWInstructionCell.h"
#import "DWInstructionMainHeader.h"
#import "SXQInstructionResultsController.h"
@interface DWInstructionMainController ()<UISearchBarDelegate,UISearchControllerDelegate>
@property (nonatomic,strong) id<SXQInstructionService> service;
@property (nonatomic,strong) UISearchController *searchController;
@end

@implementation DWInstructionMainController
- (UISearchController *)searchController
{
    if (_searchController == nil) {
        self.definesPresentationContext = YES;
        SXQInstructionResultsController *resultsVC = [[SXQInstructionResultsController alloc] initWithNavigationController:self.navigationController];
        resultsVC.searchBarTextSingal = [self rac_signalForSelector:@selector(searchBar:textDidChange:) fromProtocol:@protocol(UISearchBarDelegate)];
        _searchController = [[UISearchController alloc] initWithSearchResultsController:resultsVC];
        _searchController.hidesNavigationBarDuringPresentation = YES;
        _searchController.searchBar.delegate = self;
        //        _searchController.searchResultsUpdater = resultsVC;
        _searchController.delegate = self;
        //        resultsVC.tableView.delegate = self;
        
    }
    return _searchController;
}
- (NSArray *)expCategories
{
    if (!_expCategories) {
        _expCategories = @[];
    }
    return _expCategories;
}
- (id<SXQInstructionService>)service
{
    if (!_service) {
        _service = [[SXQInstructionServiceImpl alloc] initWithNavigationController:self.navigationController];
    }
    return _service;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self p_setupCollecitonView];
    [self p_loadData];
}
- (IBAction)searchInstruction:(UIBarButtonItem *)sender {
//        self.tabBarController.tabBar.hidden = YES;
    [self presentViewController:self.searchController animated:YES completion:nil];
}
#pragma mark - 设置collectionview
- (void)p_setupCollecitonView
{
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.title = @"说明书";
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([DWInstructionCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([DWInstructionCell class])];
}
#pragma mark - 加载数据
- (void)p_loadData
{
    @weakify(self)
    [[self.service instructionCategorySignal]
     subscribeNext:^(NSArray *resultArray){
         @strongify(self)
         self.expCategories = resultArray;
         [self.collectionView reloadData];
    }
     error:^(NSError *error) {
         
     }];
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    SXQExpCategory *expcategory = self.expCategories[indexPath.section];
    SXQInstructionListController *listVC = [SXQInstructionListController new];
    listVC.categoryItem = expcategory.expSubCategories[indexPath.row];
    [self.navigationController pushViewController:listVC animated:YES];
}
@end
