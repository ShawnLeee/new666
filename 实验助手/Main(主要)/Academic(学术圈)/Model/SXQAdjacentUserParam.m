//
//  SXQAdjacentUserParam.m
//  实验助手
//
//  Created by sxq on 15/12/3.
//  Copyright © 2015年 SXQ. All rights reserved.
//

#import "SXQAdjacentUserParam.h"

@implementation SXQAdjacentUserParam
- (CLLocationCoordinate2D)coordinate
{
    return  CLLocationCoordinate2DMake([_latitude doubleValue], [_longitude doubleValue]);
}
+ (instancetype)paramWithCoordiante:(CLLocationCoordinate2D)coordinate
{
    SXQAdjacentUserParam *param = [SXQAdjacentUserParam new];
    param.latitude = [NSString stringWithFormat:@"%f",coordinate.latitude];
    param.longitude = [NSString stringWithFormat:@"%f",coordinate.longitude];
    return param;
}
@end
