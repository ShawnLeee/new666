//
//  DWBBSTopicView.h
//  实验助手
//
//  Created by sxq on 15/12/23.
//  Copyright © 2015年 SXQ. All rights reserved.
//
@class DWBBSTopic,DWBBSTopicView;
#import <UIKit/UIKit.h>
@protocol DWBBSTopicViewDelegate <NSObject>
@optional
- (void)didClickTopicView:(DWBBSTopicView *)topicView;
@end
@interface DWBBSTopicView : UITableViewHeaderFooterView
@property (nonatomic,strong) DWBBSTopic *bbsTopic;
@property (nonatomic,weak) id<DWBBSTopicViewDelegate> delegate;
@end
