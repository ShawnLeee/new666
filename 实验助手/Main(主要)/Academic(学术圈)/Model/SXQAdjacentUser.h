//
//  SXQAdjacentUser.h
//  实验助手
//
//  Created by sxq on 15/9/15.
//  Copyright (c) 2015年 SXQ. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
@interface SXQAdjacentUser : NSObject;
@property (nonatomic,copy) NSString *mapID;
@property (nonatomic,copy) NSString *distance;
@property (nonatomic,copy) NSString *userID;
@property (nonatomic,copy) NSString *longitude;
@property (nonatomic,copy) NSString *latitude;
@property (nonatomic,copy) NSString *reagentName;
- (CLLocationCoordinate2D)coordinate;
@end