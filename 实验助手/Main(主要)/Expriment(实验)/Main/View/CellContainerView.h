//
//  CellContainerView.h
//  实验助手
//
//  Created by sxq on 15/10/23.
//  Copyright © 2015年 SXQ. All rights reserved.
//
@class SXQExpStep,CellContainerViewModel;
#import <UIKit/UIKit.h>

@interface CellContainerView : UIView
//@property (nonatomic,strong) SXQExpStep *step;
@property (nonatomic,strong) CellContainerViewModel *viewModel;
@end
