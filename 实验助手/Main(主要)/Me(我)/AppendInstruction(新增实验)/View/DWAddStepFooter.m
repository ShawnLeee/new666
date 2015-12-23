//
//  DWAddStepFooter.m
//  实验助手
//
//  Created by sxq on 15/12/15.
//  Copyright © 2015年 SXQ. All rights reserved.
//

#import "DWAddStepFooter.h"
@interface DWAddStepFooter ()
@property (nonatomic,weak) UIButton *button;
@property (nonatomic,copy) void (^addHandler)();
@end
@implementation DWAddStepFooter
- (instancetype)initWithAddHandler:(void (^)())addHandler
{
    if (self = [super init]) {
        self.addHandler = addHandler;
        [self p_addButton];
    }
    return self;
}
- (void)p_addButton
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [button setImage:[UIImage imageNamed:@"FeedSearchAddQuestion_Normal"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"FeedSearchAddQuestion_Highlight"] forState:UIControlStateHighlighted];
    [button setTitle:@"添加步骤" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(buttonClikced) forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundColor:MainBgColor];
    button.layer.cornerRadius = 4;
    _button = button;
    
    [self addSubview:button];
}
- (void)buttonClikced
{
    self.addHandler();
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    _button.frame = CGRectMake(10, 10, self.frame.size.width - 20, self.frame.size.height - 20);
}
@end
