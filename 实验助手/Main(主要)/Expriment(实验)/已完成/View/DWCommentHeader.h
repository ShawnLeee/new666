//
//  DWCommentHeader.h
//  实验助手
//
//  Created by sxq on 15/12/8.
//  Copyright © 2015年 SXQ. All rights reserved.
//

@class DWCommentHeaderViewModel,DWCommentHeader;
#import <UIKit/UIKit.h>
@protocol DWCommentHeaderDelegate <NSObject>

@optional
- (void)commentHeaderClickedFoldBtn:(DWCommentHeader *)header;
@end
@interface DWCommentHeader : UITableViewHeaderFooterView
@property (nonatomic,strong) DWCommentHeaderViewModel *viewModel;

@property (nonatomic,weak) id<DWCommentHeaderDelegate> delegate;
@end
