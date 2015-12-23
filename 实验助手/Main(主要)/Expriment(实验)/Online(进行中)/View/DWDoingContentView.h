//
//  DWDoingContentView.h
//  实验助手
//
//  Created by sxq on 15/11/13.
//  Copyright © 2015年 SXQ. All rights reserved.
//
@class DWDoingViewModel;
#import <UIKit/UIKit.h>

@interface DWDoingContentView : UIImageView
@property (nonatomic,strong) DWDoingViewModel *viewModel;
@property (nonatomic,weak) UITableViewCell *cell;
@end
