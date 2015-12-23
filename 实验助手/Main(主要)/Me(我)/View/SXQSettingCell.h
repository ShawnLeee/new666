//
//  SXQSettingCell.h
//  实验助手
//
//  Created by sxq on 15/11/4.
//  Copyright © 2015年 SXQ. All rights reserved.
//
@class SXQSettingItem;
#import <UIKit/UIKit.h>

@interface SXQSettingCell : UITableViewCell
@property (nonatomic,strong) SXQSettingItem *item;
- (void)configureCellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath item:(SXQSettingItem *)item;
@end
