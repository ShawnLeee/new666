//
//  SXQReagentDescView.m
//  实验助手
//
//  Created by sxq on 15/12/3.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "SXQAdjacentUser.h"
#import "SXQReagentDescView.h"
@interface SXQReagentDescView ()
@property (nonatomic,weak) IBOutlet UILabel *reagentsLabel;
@end
@implementation SXQReagentDescView

+ (instancetype)reagentDescView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
}
- (void)setAdjacentUser:(SXQAdjacentUser *)adjacentUser
{
    _adjacentUser = adjacentUser;
    self.reagentsLabel.text = adjacentUser.reagentName;
    if (adjacentUser.distance == 0) {
    }
}
@end
