//
//  DWAddConsumableCell.h
//  实验助手
//
//  Created by sxq on 15/12/14.
//  Copyright © 2015年 SXQ. All rights reserved.
//
@class DWAddConsumabelViewModel;

#import <UIKit/UIKit.h>

@interface DWAddConsumableCell : UITableViewCell
@property (nonatomic,strong) DWAddConsumabelViewModel *consumableViewModel;
- (void)dismissKeyboard;
@end
