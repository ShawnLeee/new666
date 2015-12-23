//
//  SXQScheduleController.m
//  实验助手
//
//  Created by sxq on 15/10/21.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "SXQAddScheduleController.h"
#import "UIBarButtonItem+SXQ.h"
#import "SXQExpPlan.h"
#import "SXQScheduleController.h"
#import "FSCalendarTestMacros.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "SXQScheduleServicesImpl.h"
#import "ArrayDataSource+TableView.h"
@interface SXQScheduleController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) id<SXQScheduleServices> services;
@property (nonatomic,weak) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *schedules;
@property (nonatomic,copy) NSString *currentDate;
@end

@implementation SXQScheduleController
- (NSMutableArray *)schedules
{
    if (_schedules == nil) {
        _schedules = [NSMutableArray array];
    }
    return _schedules;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        _services = [SXQScheduleServicesImpl new];
    }
    return self;
}
- (instancetype)init
{
    if (self = [super init]) {
        _services = [SXQScheduleServicesImpl new];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self p_setupSelf];
}
- (void)p_setupSelf
{
     UIBarButtonItem *rightBarButton = [UIBarButtonItem itemWithImage:@"Night_ZHNavigationBarAddIcon_iOS7" target:self action:@selector(addScheduleInstruction)];
    self.navigationItem.rightBarButtonItem = rightBarButton;
    
    [_calendar selectDate:[[NSDate date] fs_dateByAddingDays:0]];
    [self binding];
#if 0
    FSCalendarTestSelectDate
#endif   
    
}
- (void)binding
{
    @weakify(self)
    [RACObserve(self.calendar, selectedDate)
    subscribeNext:^(NSDate *date) {
        @strongify(self)
        self.currentDate = [self dateStringForDate:date];
    }];
    [[[[[[self rac_signalForSelector:@selector(calendar:didSelectDate:) fromProtocol:@protocol(FSCalendarDelegate)]
     map:^id(RACTuple *tuple) {
         return tuple.second;
     }]
      map:^id(NSDate *date) {
          return [self dateStringForDate:date];
      }]
      doNext:^(NSString *date) {
        @strongify(self)
          self.currentDate = date;
      }]
     flattenMap:^RACStream *(NSString *date) {
         @strongify(self)
         return [[self.services getServices] scheduleWithDate:date];
     }]
    subscribeNext:^(NSArray *expmentModelArr) {
        @strongify(self)
        self.schedules = [expmentModelArr mutableCopy];
        [self.tableView reloadData];
    }]; 
}
- (void)loadView
{
    UIView *view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    view.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.0];
    self.view = view;
    
    FSCalendar *calendar = [[FSCalendar alloc] initWithFrame:CGRectMake(0, 0, view.bounds.size.width, 300)];
    calendar.dataSource = self;
    calendar.delegate = self;
    calendar.allowsMultipleSelection = NO;
    [self.view addSubview:calendar];
    self.calendar = calendar;
    
    CGFloat calendarMaxY = CGRectGetMaxY(calendar.frame);
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    CGFloat tabbarHeight = self.tabBarController.tabBar.bounds.size.height;
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, calendarMaxY, view.bounds.size.width, screenHeight - calendarMaxY - 2*tabbarHeight) style:UITableViewStylePlain];
    tableView.contentInset = UIEdgeInsetsMake(0, 0, 10, 0);
    _tableView = tableView;
    _tableView.delegate = self;
    [self.view addSubview:tableView];
    [self setupTableViewDataSource];
    
}
- (void)setupTableViewDataSource
{
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    _tableView.dataSource = self;
}
- (NSString *)dateStringForDate:(NSDate *)date
{
    return [date fs_stringWithFormat:@"yyyy-MM-dd"];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.schedules.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SXQExpPlan *expPlan = self.schedules[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = expPlan.experimentName;
    return cell;
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    SXQExpPlan *expPlan = self.schedules[indexPath.row];
    if(editingStyle == UITableViewCellEditingStyleDelete)
    {
//        发送网络请求删除计划，刷新数据
        @weakify(self)
        [[[self.services getServices] deleteScheduleSignalWithExpPlan:expPlan]
        subscribeNext:^(NSNumber *success) {
            if ([success boolValue]) {
                @strongify(self)
                [self.schedules removeObject:expPlan];
                [self.tableView reloadData];
            }
        }];
    }
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}
#pragma mark - Private Method
- (void)addScheduleInstruction
{
    SXQExpPlan *expPlan = [SXQExpPlan new];
    expPlan.date = self.currentDate;
    SXQAddScheduleController *destinationVC = [[SXQAddScheduleController alloc] initWithExpPlan:expPlan];
    [self.navigationController pushViewController:destinationVC animated:YES];
}
- (void)viewWillAppear:(BOOL)animated
{
    [self p_refreshData];
    [super viewWillAppear:animated];
}
- (void)p_refreshData
{
    if (self.currentDate) {
        @weakify(self)
        [[[self.services getServices] scheduleWithDate:self.currentDate]
         subscribeNext:^(NSArray *expmentModelArr) {
             @strongify(self)
                self.schedules = [expmentModelArr mutableCopy];
                [self.tableView reloadData];
         }];
    }
}
@end
