//
//  SXQSettingController.m
//  实验助手
//
//  Created by sxq on 15/11/4.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "SXQSettingItem.h"
#import <MJExtension/MJExtension.h>
#import "SXQSettingController.h"
#import "SXQSettingCell.h"
@interface SXQSettingController ()
@property (nonatomic,strong) NSArray *settingItems;
@end

@implementation SXQSettingController
- (instancetype)initWithStyle:(UITableViewStyle)style
{
    return [super initWithStyle:UITableViewStyleGrouped];
}
- (NSArray *)settingItems
{
    if (_settingItems == nil) {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"setting.plist" ofType:nil];
        _settingItems = [SXQSettingItem objectArrayWithFile:filePath];
    }
    return _settingItems;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"SXQSettingCell" bundle:nil] forCellReuseIdentifier:@"SettingCell"];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.settingItems.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SXQSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SettingCell" forIndexPath:indexPath];
    [cell configureCellWithTableView:tableView indexPath:indexPath item:self.settingItems[indexPath.row]];
//    cell.separatorInset = UIEdgeInsetsMake(0,INFINITY, 0, 0);
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SXQSettingItem  *settingItem = self.settingItems[indexPath.row];
    NSString *segueIdentifier = settingItem.segueIdentifier;
    [self performSegueWithIdentifier:segueIdentifier sender:nil];
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
//    cell.separatorInset = UIEdgeInsetsMake(0, INFINITY, 0, 0);
}
@end
