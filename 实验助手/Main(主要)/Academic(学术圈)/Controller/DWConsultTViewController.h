//
//  DWConsultTViewController.h
//  DWContainerViewController
//
//  Created by sxq on 15/9/17.
//  Copyright (c) 2015年 sxq. All rights reserved.
//
#import "DWConsultNav.h"
#import <UIKit/UIKit.h>

@interface DWConsultTViewController : UITableViewController<DWConsultNav>
@property (nonatomic,weak) UIViewController *parentVC;
@end
