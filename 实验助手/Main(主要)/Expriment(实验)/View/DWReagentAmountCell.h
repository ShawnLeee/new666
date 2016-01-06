//
//  DWReagentAmountCell.h
//  实验助手
//
//  Created by sxq on 15/11/20.
//  Copyright © 2015年 SXQ. All rights reserved.
//
@class DWReagentAmountViewModel;
#import <UIKit/UIKit.h>
extern NSString * const kAmountIsEditingNotification;
@interface DWReagentAmountCell : UITableViewCell
@property (nonatomic,strong) DWReagentAmountViewModel *viewModel;
@end
