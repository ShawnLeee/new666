//
//  SXQReviewDetailController.m
//  实验助手
//
//  Created by sxq on 15/11/9.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "SXQReview.h"
#import "SXQReviewDetailController.h"
#import "SXQReviewDetail.h"
#import "ArrayDataSource+TableView.h"
#import "DWGroup.h"
#import "SXQReviewItem.h"
#import "DWReviewDetailCell.h"
#import "DWReviewDetailFooter.h"
@interface SXQReviewDetailController ()
@property (nonatomic,strong) SXQReview *review;
@property (nonatomic,strong) id<DWInstructionService> service;
@property (nonatomic,strong) ArrayDataSource *arraryDataSource;
@property (nonatomic,strong) NSMutableArray *groups;
@property (nonatomic,weak) DWReviewDetailFooter *footer;
@end
@implementation SXQReviewDetailController
- (NSMutableArray *)groups
{
    if (!_groups) {
        _groups = [NSMutableArray array];
    }
    return _groups;
}
- (instancetype)initWithReview:(SXQReview *)review service:(id<DWInstructionService>)service
{
    self = [super init];
    if (self) {
        _review = review;
        _service = service;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self p_setupTableFooter];
    [self p_setupTableView];
    [self p_loadReviewDetailData];
}
- (void)p_setupTableView
{
    self.title = @"评论详情";
    self.tableView.allowsSelection = NO;
    [self.tableView registerNib:[UINib nibWithNibName:@"DWReviewDetailCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([DWReviewDetailCell class])];
    _arraryDataSource = [[ArrayDataSource alloc] initWithGroups:self.groups];
    self.tableView.dataSource = _arraryDataSource;
}
- (void)p_loadReviewDetailData
{
    @weakify(self)
    [[[self.service reviewDetailSignalWithReview:self.review]
     map:^id(SXQReviewDetail *reviewDetail) {
         @strongify(self)
         self.footer.reviewInfo = reviewDetail.reviewInfo;
         [self p_layoutTableFooter];
         return [self groupWithReviewDetail:reviewDetail];
     }]
    subscribeNext:^(DWGroup *group) {
        @strongify(self)
        [self.groups insertObject:group atIndex:0];
        [self.tableView reloadData];
        
    } error:^(NSError *error) {
        
    }];
}
- (DWGroup *)groupWithReviewDetail:(SXQReviewDetail *)reviewDetail
{
    DWGroup *group = [[DWGroup alloc] initWithWithHeader:nil footer:nil items:reviewDetail.reviewOpts];
    group.identifier = NSStringFromClass([DWReviewDetailCell class]);
    group.configureBlk = ^(DWReviewDetailCell *cell,SXQReviewItem *item)
    {
        cell.reviewItem = item;
    };
    return group;
}
- (void)p_setupTableFooter
{
    DWReviewDetailFooter *detailFooter = [[DWReviewDetailFooter alloc] initWithFrame:CGRectMake(0, 0, 30, 40)];
    _footer = detailFooter;
    self.tableView.tableFooterView = detailFooter;
}
- (void)p_layoutTableFooter
{
    [self.footer setNeedsLayout];
    [self.footer layoutIfNeeded];
    
    CGFloat height = [self.footer systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    CGRect footerFrame = self.footer.frame;
    footerFrame.size.height = height;
    self.footer.frame = footerFrame;
}
@end
