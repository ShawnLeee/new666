//
//  DWAddReagentCell.h
//  实验助手
//
//  Created by sxq on 15/12/10.
//  Copyright © 2015年 SXQ. All rights reserved.
//
@class DWAddReagentViewModel;
#import <UIKit/UIKit.h>

@interface DWAddReagentCell : UITableViewCell
@property (nonatomic,strong) DWAddReagentViewModel *reagentViewModel;
- (void)dismissKeyBoard;
@end
