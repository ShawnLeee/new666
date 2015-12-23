//
//  DWDoingCell.h
//  实验助手
//
//  Created by sxq on 15/11/13.
//  Copyright © 2015年 SXQ. All rights reserved.
//
@class DWDoingViewModel,DWDoingCell;
#import <UIKit/UIKit.h>

@protocol DWDoingCellDelegate <NSObject>
@optional
- (void)doingCell:(DWDoingCell *)cell clickedPreviewButton:(id)previewButton;
@end
@interface DWDoingCell : UITableViewCell
@property (nonatomic,strong) DWDoingViewModel *viewModel;
@property (nonatomic,weak) id<DWDoingCellDelegate> delegate;
@end
