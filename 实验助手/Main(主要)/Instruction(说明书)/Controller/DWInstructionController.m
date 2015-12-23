//
//  DWInstructionController.m
//  实验助手
//
//  Created by sxq on 15/9/16.
//  Copyright (c) 2015年 SXQ. All rights reserved.
//
#import "SXQInstructionDetailController.h"
#import "SXQInstructionListController.h"
#import "DWInstructionController.h"
#import "SXQColor.h"
#import "UIView+MJ.h"
#import "UIBarButtonItem+MJ.h"
#import "SXQExpSubCategory.h"
#import "SXQInstructionResultsController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
@interface DWInstructionController ()<UISearchControllerDelegate,UISearchBarDelegate>
@property (nonatomic,assign) BOOL menuFold;
@property (nonatomic,weak) UICollectionView *centerView;
@property (nonatomic,strong) UISearchController *searchController;
@end

@implementation DWInstructionController
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
- (instancetype)init
{
    if (self = [super init]) {
        _menuFold = NO;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self p_setup];
}
- (void)p_setup
{
//    self.edgesForExtendedLayout = UIRectEdgeNone;
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
//    [button addTarget:self action:@selector(menuButtonClicked) forControlEvents:UIControlEventTouchUpInside];
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
//    
//    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithIcon:@"search-20x20" highIcon:nil target:self action:@selector(showSearchVC)];
//    
//    //初始化子控制器
//    //1.左侧菜单
//    SXQMenuViewController *menuVC = [SXQMenuViewController new];
//    menuVC.view.width = MJMenuWidth;
//    menuVC.view.y = 0;
//    menuVC.view.height = self.view.frame.size.height;
//    [self.view addSubview:menuVC.view];
//    [self addChildViewController:menuVC];
//    
//    //2.中间内容
//    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
//    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
//    layout.itemSize = CGSizeMake(80, 80);
//    DWInstructionChildController *centerVC = [[DWInstructionChildController alloc] initWithCollectionViewLayout:layout];
//    centerVC.collectionView.frame = CGRectOffset(self.view.bounds, MJMenuWidth, 0);
//    centerVC.delegate = self;
//    [self.view addSubview:centerVC.collectionView];
//    _centerView = centerVC.collectionView;
//    [self addChildViewController:centerVC];
//    
//    menuVC.delegate = centerVC;
//    // 2.监听手势
//    [_centerView addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(dragView:)]];
}
- (void)showSearchVC
{
//    self.tabBarController.tabBar.hidden = YES;
    [self presentViewController:self.searchController animated:YES completion:nil];
}
- (void)dragView:(UIPanGestureRecognizer *)panGesture
{
    CGPoint point = [panGesture translationInView:panGesture.view];
    //Drag ended.
    if (panGesture.state == UIGestureRecognizerStateCancelled || panGesture.state == UIGestureRecognizerStateEnded) {
        if (panGesture.view.x <= MJMenuWidth * 0.5) {//往左边走动至少一半
            [self p_foldMenu];
        }else
        {
            [self p_unfoldMenu];
        }
    }else//while draging
    {
        panGesture.view.transform = CGAffineTransformTranslate(panGesture.view.transform, point.x, 0);
        [panGesture setTranslation:CGPointZero inView:panGesture.view];
        if (panGesture.view.x <= 0) {
            panGesture.view.transform = CGAffineTransformMakeTranslation(-MJMenuWidth, 0);
        }else if(panGesture.view.x >= MJMenuWidth)
        {
            panGesture.view.transform = CGAffineTransformIdentity;
        }
    }
}
- (void)menuButtonClicked
{
    if (_menuFold) {
        [self p_unfoldMenu];
    }else
    {
        [self p_foldMenu];
    }
}
#pragma mark - Private Method
- (void)p_foldMenu
{
    [UIView animateWithDuration:0.5 animations:^{
         _centerView.transform = CGAffineTransformMakeTranslation(-MJMenuWidth, 0);
    }];
    _menuFold = !_menuFold;
}
- (void)p_unfoldMenu
{
    [UIView animateWithDuration:0.5 animations:^{
        _centerView.transform = CGAffineTransformIdentity;
    }];
    _menuFold = !_menuFold;
}

#pragma mark instuctionController Delegate Method
//- (void)instructionController:(DWInstructionChildController *)vc SelectedItem:(SXQExpSubCategory *)item
//{
//    SXQInstructionListController *listVC = [SXQInstructionListController new];
//    listVC.categoryItem = item;
//    [self.navigationController pushViewController:listVC  animated:YES];
//}
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    SXQInstructionDetailController *detailVC = [[SXQInstructionDetailController alloc] initWithInstruction:nil];
//    [self.navigationController pushViewController:detailVC animated:YES];
//}
//
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
//    self.tabBarController.tabBar.hidden = NO;
}
@end
