//
//  SXQInstructionResultsController.h
//  实验助手
//
//  Created by sxq on 15/10/29.
//  Copyright © 2015年 SXQ. All rights reserved.
//
@class RACSignal;
#import <UIKit/UIKit.h>

@interface SXQInstructionResultsController : UITableViewController<UISearchBarDelegate>
- (instancetype)initWithNavigationController:(UINavigationController *)nav;
@property (nonatomic,strong) RACSignal *searchBarTextSingal;
@end
