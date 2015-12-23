//
//  DWStarView.h
//  实验助手
//
//  Created by sxq on 15/11/23.
//  Copyright © 2015年 SXQ. All rights reserved.
//
@class DWCommentViewModel;
#import <UIKit/UIKit.h>

@interface DWStarView : UIView
@property (nonatomic,assign) NSUInteger scores;
@property (nonatomic,strong) DWCommentViewModel *viewModel;
@end
