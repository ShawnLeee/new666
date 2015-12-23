//
//  DWItemCell.h
//  实验助手
//
//  Created by sxq on 15/12/11.
//  Copyright © 2015年 SXQ. All rights reserved.
//
@class DWItemCellViewModel;
#import <UIKit/UIKit.h>

@interface DWItemCell : UITableViewCell
@property (nonatomic,strong) DWItemCellViewModel *viewModel;
@end
