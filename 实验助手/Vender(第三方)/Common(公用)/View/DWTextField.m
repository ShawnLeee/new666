//
//  DWTextField.m
//  DBT
//
//  Created by sxq on 15/12/11.
//  Copyright © 2015年 sxq. All rights reserved.
//

#import "DWTextField.h"

@implementation DWTextField
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self p_setRightView];
    }
    return self;
}
- (CGRect)rightViewRectForBounds:(CGRect)bounds
{
    return CGRectMake(bounds.size.width - 35, 0, 30, 30);
}
- (void)p_setRightView
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rightButton = button;
    [button setImage:[UIImage imageNamed:@"timeline_icon_read_more"] forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, button.currentImage.size.width, button.currentImage.size.height);
    button.imageView.contentMode = UIViewContentModeCenter;
    self.rightView = button;
    self.rightViewMode = UITextFieldViewModeUnlessEditing;
}

@end
