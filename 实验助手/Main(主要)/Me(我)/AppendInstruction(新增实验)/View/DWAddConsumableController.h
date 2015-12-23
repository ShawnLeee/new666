//
//  DWAddConsumableController.h
//  实验助手
//
//  Created by sxq on 15/12/14.
//  Copyright © 2015年 SXQ. All rights reserved.
//
@class DWAddExpConsumable;
#import <UIKit/UIKit.h>

@interface DWAddConsumableController : UITableViewController
@property (nonatomic,copy) void (^doneBlock)(DWAddExpConsumable *addExpConsumable);
@end
