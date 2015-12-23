//
//  SXQReagentAnnotation.h
//  实验助手
//
//  Created by sxq on 15/12/3.
//  Copyright © 2015年 SXQ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
@class SXQAdjacentUser;
@interface SXQReagentAnnotation : NSObject<MKAnnotation>
@property (nonatomic,assign) CLLocationCoordinate2D coordinate;
@property (nonatomic,strong) SXQAdjacentUser *adjacentUser;
+ (instancetype)reagentAnnotationWithUser:(SXQAdjacentUser *)user;
@end
