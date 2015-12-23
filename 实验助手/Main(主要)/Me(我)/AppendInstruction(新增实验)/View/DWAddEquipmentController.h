//
//  DWAddEquipmentController.h
//  实验助手
//
//  Created by sxq on 15/12/14.
//  Copyright © 2015年 SXQ. All rights reserved.
//
@class DWAddExpEquipment;
#import <UIKit/UIKit.h>

@interface DWAddEquipmentController : UITableViewController
@property (nonatomic,copy) void (^doneBlock)(DWAddExpEquipment *addExpEquipment);
@end
