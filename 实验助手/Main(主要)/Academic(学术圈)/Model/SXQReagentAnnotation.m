//
//  SXQReagentAnnotation.m
//  实验助手
//
//  Created by sxq on 15/12/3.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "SXQAdjacentUser.h"
#import "SXQReagentAnnotation.h"

@implementation SXQReagentAnnotation
- (void)setAdjacentUser:(SXQAdjacentUser *)adjacentUser
{
    _adjacentUser = adjacentUser;
    self.coordinate = adjacentUser.coordinate;
}
+ (instancetype)reagentAnnotationWithUser:(SXQAdjacentUser *)user
{
    SXQReagentAnnotation *annotation = [SXQReagentAnnotation new];
    annotation.adjacentUser = user;
    return annotation;
}
@end
