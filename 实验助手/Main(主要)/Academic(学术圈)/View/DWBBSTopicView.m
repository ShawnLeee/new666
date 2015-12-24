//
//  DWBBSTopicView.m
//  实验助手
//
//  Created by sxq on 15/12/23.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "DWBBSTopic.h"
#import "DWBBSTopicView.h"
#import <UIImageView+WebCache.h>
@interface DWBBSTopicView()
@property (nonatomic,weak) IBOutlet UIImageView *userIconView;
@property (nonatomic,weak) IBOutlet UILabel *userNameLabel;
@property (nonatomic,weak) IBOutlet UILabel *createTimeLabel;
@property (nonatomic,weak) IBOutlet UILabel *topicLabel;
@property (nonatomic,weak) IBOutlet UILabel *topicContentLabel;
@end
@implementation DWBBSTopicView
- (void)awakeFromNib
{
    UITapGestureRecognizer *tapRecoginzer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHandler:)];
    [self addGestureRecognizer:tapRecoginzer];
}
- (UIView *)contentView
{
    return [self.subviews firstObject];
}
- (void)setBbsTopic:(DWBBSTopic *)bbsTopic
{
    _bbsTopic = bbsTopic;
    UIImage *placeHolderImage = [UIImage imageNamed:@"avatar_default"];
    NSURL *url = [NSURL URLWithString:bbsTopic.icon];
    [self.userIconView sd_setImageWithURL:url placeholderImage:placeHolderImage];
    self.userNameLabel.text = bbsTopic.creator;
    self.createTimeLabel.text = bbsTopic.timeStr;
    self.topicLabel.text = bbsTopic.topicName;
    self.topicContentLabel.text = bbsTopic.topicDetail;
    
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.userIconView.layer.cornerRadius = self.userIconView.bounds.size.width/2;
    self.userIconView.clipsToBounds = YES;
}
- (void)tapHandler:(UITapGestureRecognizer *)tapGestureRecognizer
{
    if ([self.delegate respondsToSelector:@selector(didClickTopicView:)]) {
        [self.delegate didClickTopicView:self];
    }
}
@end
