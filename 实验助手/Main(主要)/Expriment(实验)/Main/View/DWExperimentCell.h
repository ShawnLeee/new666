//
//  DWExperimentCell.h
//  实验助手
//
//  Created by sxq on 15/10/23.
//  Copyright © 2015年 SXQ. All rights reserved.
//
@class SXQExpStep,CellContainerViewModel,DWExperimentCell;
#import <UIKit/UIKit.h>

@interface DWExperimentCell : UITableViewCell
//@property (nonatomic,strong) SXQExpStep *step;
@property (nonatomic,strong) CellContainerViewModel *viewModel;
@end
