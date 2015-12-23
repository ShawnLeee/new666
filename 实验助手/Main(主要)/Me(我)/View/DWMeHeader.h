//
//  DWMeHeader.h
//  实验助手
//
//  Created by sxq on 15/11/25.
//  Copyright © 2015年 SXQ. All rights reserved.
//
@class DWMeHeader,DWUserIcon;
#import <UIKit/UIKit.h>
@protocol DWMeHeaderDelegate <NSObject>
@optional
- (void)dw_meHeader:(DWMeHeader *)header didClickedHeaderButton:(UIButton *)button;
- (void)dw_meHeader:(DWMeHeader *)header didClickedUserIcon:(UIImageView *)userIconView;
@end
@interface DWMeHeader : UIView
@property (nonatomic,weak) id<DWMeHeaderDelegate> delegate;
@property (nonatomic,strong) DWUserIcon *userIconModel;
@end
