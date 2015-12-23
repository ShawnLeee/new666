//
//  DWMeHeader.m
//  实验助手
//
//  Created by sxq on 15/11/25.
//  Copyright © 2015年 SXQ. All rights reserved.
//

#import "DWUserIcon.h"
#import "DWMeHeader.h"
#import <UIImageView+WebCache.h>
@interface DWMeHeader ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (nonatomic,weak) IBOutlet UIView *headerView;
@property (nonatomic,weak) IBOutlet UIImageView *userIcon;
@property (nonatomic,weak) IBOutlet UILabel *userName;
@property (nonatomic,weak) IBOutlet UIButton *headerButton;
@property (nonatomic,assign) BOOL didSetupConstraints;
@end
@implementation DWMeHeader
- (void)p_setupRecoginzer
{
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(p_changeIcon:)];
    [self.userIcon addGestureRecognizer:tapRecognizer];
}
- (void)p_changeIcon:(UITapGestureRecognizer *)recoginzer
{
    if([self.delegate respondsToSelector:@selector(dw_meHeader:didClickedUserIcon:)])
    {
        [self.delegate dw_meHeader:self didClickedUserIcon:self.userIcon];
    }
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self p_setup];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self p_setup];
    }
    return self;
}
- (void)p_setup
{
    _didSetupConstraints = NO;
    self.frame = CGRectMake(0, 0, 300, 80);
    [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([DWMeHeader class]) owner:self options:nil];
    [self addSubview:_headerView];
    _headerView.translatesAutoresizingMaskIntoConstraints = NO;
//    [self setNeedsUpdateConstraints];
    [self p_setupRecoginzer];
}
- (void)updateConstraints
{
    if (!_didSetupConstraints) {
        [self p_setupConstaints];
        _didSetupConstraints = YES;
    }
    [super updateConstraints];
}
- (void)p_setupConstaints
{
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.headerView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.headerView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.headerView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.headerView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0]];
}
- (IBAction)buttonClicked:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(dw_meHeader:didClickedHeaderButton:)]) {
        [self.delegate dw_meHeader:self didClickedHeaderButton:sender];
    }
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.userIcon.layer.cornerRadius = self.userIcon.frame.size.width/2;
    self.userIcon.clipsToBounds = YES;
}
- (void)setUserIconModel:(DWUserIcon *)userIconModel
{
    _userIconModel = userIconModel;
    self.nameLabel.text = userIconModel.nickName;
    NSURL *imageurl = [NSURL URLWithString:userIconModel.icon];
    UIImage *placeHolderImage = [UIImage imageNamed:@"avatar_default"];
    [self.userIcon sd_setImageWithURL:imageurl placeholderImage:placeHolderImage];
}
@end
