//
//  DWBBSThemeCell.m
//  实验助手
//
//  Created by sxq on 15/12/1.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "DWBBSTheme.h"
#import "DWBBSThemeCell.h"
@interface DWBBSThemeCell ()
@property (nonatomic,weak) IBOutlet UILabel *topicNameLabel;
@property (nonatomic,weak) IBOutlet UILabel *creatorLabel;
@property (nonatomic,weak) IBOutlet UILabel *reviewCountLabel;
@end
@implementation DWBBSThemeCell
- (void)setBbsTheme:(DWBBSTheme *)bbsTheme
{
    _bbsTheme = bbsTheme;
    self.topicNameLabel.text = bbsTheme.topicName;
    self.creatorLabel.text = bbsTheme.topicCreator;
    self.reviewCountLabel.text = bbsTheme.reviewCount;
}
@end
