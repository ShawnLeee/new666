//
//  DWSignUpHeader.m
//  实验助手
//
//  Created by sxq on 15/11/18.
//  Copyright © 2015年 SXQ. All rights reserved.
//

#import "DWSignUpHeader.h"
#import "DWGroup.h"
@interface DWSignUpHeader()
@property (nonatomic,weak) UILabel *headerLabel;
@end
@implementation DWSignUpHeader
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self p_addCustomViews];
    }
    return self;
}
- (void)p_addCustomViews
{
    UILabel *headerLabel = [[UILabel alloc] init];
    headerLabel.textColor = [UIColor colorWithRed:0.00 green:0.64 blue:0.70 alpha:1.0];
    headerLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:headerLabel];
    _headerLabel = headerLabel;
    _headerLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self p_addConstraints];
    [self layoutIfNeeded];
}
- (void)setGroup:(DWGroup *)group
{
    _group = group;
    self.headerLabel.text = group.headerTitle;
}
- (void)p_addConstraints
{
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.headerLabel attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeading multiplier:1.0 constant:10]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.headerLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
}
@end
