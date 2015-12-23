//
//  DWAddEquipmentCell.h
//  实验助手
//
//  Created by sxq on 15/12/14.
//  Copyright © 2015年 SXQ. All rights reserved.
//

@class DWAddEquipmentViewModel;
#import <UIKit/UIKit.h>
@interface DWAddEquipmentCell : UITableViewCell
@property (nonatomic,strong) DWAddEquipmentViewModel *equipmentViewModel;
- (void)dismissKeyboard;
@end
