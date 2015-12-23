//
//  SXQCommentView.m
//  Comment
//
//  Created by sxq on 15/11/6.
//  Copyright © 2015年 sxq. All rights reserved.
//

#import "SXQCommentView.h"
@interface SXQCommentView ()
@property (nonatomic,weak) IBOutlet UIView *view;
@property (nonatomic,weak) IBOutlet UIStackView *stackView;
@property (nonatomic,strong) IBOutletCollection(UIButton) NSArray *starButtons;
@property (nonatomic,assign) BOOL didSetupContraints;
@end
static const NSUInteger kStarCount = 5;
@implementation SXQCommentView
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self p_setup];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self p_setup];
    }
    return self;
}
- (void)p_setup
{
    _didSetupContraints = NO;
    _scores = 0;
    [[NSBundle mainBundle] loadNibNamed:@"SXQCommentView" owner:self options:nil];
    [self addSubview:_view];
    
}
- (void)updateConstraints
{
    if (!_didSetupContraints) {
        [self p_setupConstraints];
        _didSetupContraints = YES;
    }
    [super updateConstraints];
}
- (void)p_setupConstraints
{
    _view.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_view attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_view attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0]];
}
- (IBAction)didClickStarButton:(UIButton *)starButton
{
    NSUInteger index = starButton.tag;
    //Set button.selected to YES that tag small than index and others to NO
    for (int i = 0; i < kStarCount; i++) {
        UIButton *button = self.starButtons[i];
        if (button.tag <= index) {
            button.selected = YES;
        }else
        {
            button.selected = NO;
        }
    }
    _scores = index + 1;
    
}
- (void)setScores:(NSUInteger)scores
{
    _scores = scores;
    for (int i = 0; i < kStarCount; i++) {
        UIButton *button = self.starButtons[i];
        if (button.tag < scores) {
            button.selected = YES;
        }else
        {
            button.selected = NO;
        }
    }
}
@end
