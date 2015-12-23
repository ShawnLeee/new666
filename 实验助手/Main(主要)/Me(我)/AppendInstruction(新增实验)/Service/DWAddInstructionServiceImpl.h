//
//  DWAddInstructionServiceImpl.h
//  实验助手
//
//  Created by sxq on 15/12/10.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "DWAddInstructionService.h"
#import <Foundation/Foundation.h>

@interface DWAddInstructionServiceImpl : NSObject<DWAddInstructionService>
- (instancetype)initWithNavigationController:(UINavigationController *)navigationController tableView:(UITableView *)tableView;
@end
