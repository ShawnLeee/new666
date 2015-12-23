//
//  SXQAdjacentUserParam.h
//  实验助手
//
//  Created by sxq on 15/12/3.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "SXQBaseParam.h"
#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
@interface SXQAdjacentUserParam : SXQBaseParam
@property (nonatomic,copy) NSString *longitude;
@property (nonatomic,copy) NSString *latitude;
+ (instancetype)paramWithCoordiante:(CLLocationCoordinate2D)coordinate;
@end
