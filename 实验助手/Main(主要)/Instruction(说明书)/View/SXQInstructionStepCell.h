//
//  SXQInstructionStepCell.h
//  实验助手
//
//  Created by sxq on 15/9/23.
//  Copyright © 2015年 SXQ. All rights reserved.
//
@class DWInstructionStepViewModel;
#import <UIKit/UIKit.h>

@interface SXQInstructionStepCell : UITableViewCell
@property (nonatomic,strong) DWInstructionStepViewModel *viewModel;
- (void)configureCellWithItem:(id)item;
@end
