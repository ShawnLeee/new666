//
//  DWMeInstructionCell.h
//  实验助手
//
//  Created by sxq on 15/11/25.
//  Copyright © 2015年 SXQ. All rights reserved.
//
@class SXQExpInstruction,DWMeInstructionCell;

#import <UIKit/UIKit.h>

@protocol DWMeInstructionCellDelegate <NSObject>
@optional

- (void)instrucitonCell:(DWMeInstructionCell *)cell didClickedShareButton:(UIButton *)button;

- (void)instrucitonCell:(DWMeInstructionCell *)cell didClickedUploadButton:(UIButton *)button;

@end

@interface DWMeInstructionCell : UITableViewCell
@property (nonatomic,strong) SXQExpInstruction *instruction;
@property (nonatomic,weak) id<DWMeInstructionCellDelegate> delegate;
- (void)close;
@end
