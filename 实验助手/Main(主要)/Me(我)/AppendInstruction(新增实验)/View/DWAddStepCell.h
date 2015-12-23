//
//  DWAddStepCell.h
//  实验助手
//
//  Created by sxq on 15/12/15.
//  Copyright © 2015年 SXQ. All rights reserved.
//
@class DWAddStepViewModel;
#import <UIKit/UIKit.h>

@interface DWAddStepCell : UITableViewCell
@property (nonatomic,strong) DWAddStepViewModel *stepViewModel;
@property (nonatomic,weak) UITableView *tableView;
@end
