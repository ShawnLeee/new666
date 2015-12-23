//
//  DWBBSThemeController.m
//  实验助手
//
//  Created by sxq on 15/12/1.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import <MJRefresh/MJRefresh.h>
#import "SXQNavgationController.h"
#import "DWAddThemeParam.h"
#import "UIBarButtonItem+MJ.h"
#import "DWBBSThemeCell.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "DWBBSModel.h"
#import "DWBBSThemeController.h"
#import "DWBBSAddThemeController.h"
@interface DWBBSThemeController ()<UISearchBarDelegate,UISearchDisplayDelegate>
@property (nonatomic,strong) NSArray *themes;
@property (nonatomic,strong) NSArray *searchResultThemes;
@property (nonatomic,weak) IBOutlet UISearchBar *themeSearchBar;
@end

@implementation DWBBSThemeController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView.header beginRefreshing];
}
- (NSArray *)searchResultThemes
{
    if (!_searchResultThemes) {
        _searchResultThemes = @[];
    }
    return _searchResultThemes;
}
- (NSArray *)themes
{
    if (!_themes) {
        _themes = @[];
    }
    return _themes;
}
- (instancetype)initWithBBSModel:(DWBBSModel *)bbsModel bbsTool:(id<DWBBSTool>)bbsTool
{
    if (self = [super init]) {
        _bbsModel = bbsModel;
        _bbsTool = bbsTool;
        _themes = @[];
    }
    return self;
}
#pragma mark - 下拉刷新
- (void)p_setupRefresh
{
    
    MJRefreshStateHeader *header = [MJRefreshStateHeader headerWithRefreshingBlock:^{
        @weakify(self)
        [[self.bbsTool themesWithBBSModel:_bbsModel]
         subscribeNext:^(NSArray *themes) {
             @strongify(self)
             self.themes = themes;
             [self.tableView reloadData];
             [self.tableView.header endRefreshing];
         }];
    }];
    self.tableView.header = header;
    [self.tableView.header beginRefreshing];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self p_setupNavigationItem];
    [self p_setupTableView];
//    [self p_loadData];
    [self p_setupRefresh];
    [self p_setupSearchBar];
}
- (void)p_setupNavigationItem
{
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithIcon:@"FeedSearchAddQuestion_Normal"
                                                                  highIcon:@"FeedSearchAddQuestion_Highlight"
                                                                    target:self
                                                                    action:@selector(p_addTheme)
                                                                      size:CGSizeMake(20, 20)];
}
- (void)p_addTheme
{
    DWAddThemeParam *param = [DWAddThemeParam paramWithModuleID:_bbsModel.moduleID];
    DWBBSAddThemeController *themeVC = [[DWBBSAddThemeController alloc] initWithAddThemeParam:param bbsTool:self.bbsTool];
    SXQNavgationController *nav = [[SXQNavgationController alloc] initWithRootViewController:themeVC];
    [self presentViewController:nav animated:YES completion:nil];
}
- (void)p_setupSearchBar
{
    @weakify(self)
    [[[[[self rac_signalForSelector:@selector(searchBar:textDidChange:) fromProtocol:@protocol(UISearchBarDelegate)]
    throttle:0.5]
     map:^id(RACTuple *tuple) {
         return tuple.second;
     }]
    flattenMap:^RACStream *(NSString *text) {
        @strongify(self)
        return [self.bbsTool signalForThemeSearchWithText:text moduleID:self.bbsModel.moduleID];
    }]
    subscribeNext:^(NSArray *themes) {
        @strongify(self)
        self.searchResultThemes = themes;
        [self.searchDisplayController.searchResultsTableView reloadData];
    }];
}
- (void)p_setupTableView
{
    self.title = _bbsModel.moduleName;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 50;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([DWBBSThemeCell class]) bundle:nil] forCellReuseIdentifier: NSStringFromClass([DWBBSThemeCell class])];
    
    UITableView *resultsView = self.searchDisplayController.searchResultsTableView;
    [resultsView registerNib:[UINib nibWithNibName:NSStringFromClass([DWBBSThemeCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([DWBBSThemeCell class])];
    resultsView.rowHeight = UITableViewAutomaticDimension;
    resultsView.estimatedRowHeight = 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([tableView isEqual:self.searchDisplayController.searchResultsTableView]) {
        return self.searchResultThemes.count;
    }else
    {
        return self.themes.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DWBBSThemeCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([DWBBSThemeCell class]) forIndexPath:indexPath];
    DWBBSTheme *theme = nil;
    if ([tableView isEqual:self.searchDisplayController.searchResultsTableView]) {
        theme = self.searchResultThemes[indexPath.row];
    }else
    {
        theme = self.themes[indexPath.row];
    }
    cell.bbsTheme = theme;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.bbsTool bbsPushModel:self.themes[indexPath.row]];
}

@end
