//
//  DWDoingActionBar.h
//  实验助手
//
//  Created by sxq on 15/11/13.
//  Copyright © 2015年 SXQ. All rights reserved.
//
@class DWButton;
#import <UIKit/UIKit.h>
@class DWDoingViewModel;
@interface DWDoingActionBar : UIImageView
@property (nonatomic,strong) DWDoingViewModel *viewModel;
@property (weak, nonatomic) IBOutlet DWButton *viewBtn;
@end
