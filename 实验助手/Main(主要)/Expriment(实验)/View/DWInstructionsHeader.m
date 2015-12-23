//
//  DWInstructionsHeader.m
//  实验助手
//
//  Created by sxq on 15/12/22.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "DWInstructionsHeader.h"
#import "DWGroup.h"
@interface DWInstructionsHeader ()
@property (nonatomic,weak) IBOutlet UILabel *headTitleLabel;
@end

@implementation DWInstructionsHeader

- (UIView *)contentView
{
    return [self.subviews firstObject];
}
- (void)setGroup:(DWGroup *)group
{
    _group = group;
    self.headTitleLabel.text = group.headerTitle;
}
@end
