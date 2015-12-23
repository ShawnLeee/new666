//
//  SXQReagentContoller.m
//  实验助手
//
//  Created by sxq on 15/9/14.
//  Copyright (c) 2015年 SXQ. All rights reserved.
//
@import MapKit;
@import CoreLocation;
#import "SXQNavgationController.h"
#import "SXQAddReagentExchangeController.h"
#import "SXQReagentContoller.h"
#import "SXQReagentAnnotation.h"
#import "SXQReagentAnnotationView.h"
#import "SXQAdjacentUser.h"
#import "SXQAdjacentUserParam.h"
#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
@interface SXQReagentContoller ()<MKMapViewDelegate,CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic,strong) CLLocationManager *locationManager;
@property (nonatomic,strong) id<DWAcademicService> service;
@end
@implementation SXQReagentContoller
- (instancetype)initWithService:(id<DWAcademicService>)service
{
    if (self = [super init]) {
        _service = service;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    if (IS_OS_8_OR_LATER) {
        [self.locationManager requestAlwaysAuthorization];
    }
    [self.locationManager startUpdatingLocation];
    self.mapView.showsUserLocation = YES;
    _mapView.userTrackingMode = MKUserTrackingModeFollow;
    _mapView.mapType = MKMapTypeStandard;
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[SXQReagentAnnotation class]]) {
        SXQReagentAnnotationView *annoView = [SXQReagentAnnotationView annotationViewWithMapView:mapView];
        annoView.annotation = annotation;
        return annoView;
    }
    return nil;
    
}
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    CLLocationCoordinate2D currentLocation = userLocation.location.coordinate;
    [_mapView setCenterCoordinate:currentLocation animated:YES];
    MKCoordinateSpan span = MKCoordinateSpanMake(0.021321, 0.019366);
    MKCoordinateRegion region = MKCoordinateRegionMake(currentLocation, span);
    [_mapView setRegion:region];
    [self addAdjacentUserWithCurrentLocation:userLocation.coordinate];
}
//获取附近用户添加大头针
- (void)addAdjacentUserWithCurrentLocation:(CLLocationCoordinate2D)currentLocationCoordinate
{
    SXQAdjacentUserParam *param = [SXQAdjacentUserParam paramWithCoordiante:currentLocationCoordinate];
    [[[self.service getReagentExchangeTool] adjacentUserSignalWith:param]
    subscribeNext:^(NSArray *annotations) {
        [self p_addAnnotations:annotations];
    }];
}
- (void)p_addAnnotations:(NSArray *)annotations
{
    [annotations enumerateObjectsUsingBlock:^(SXQReagentAnnotation *annotation, NSUInteger idx, BOOL *stop) {
            [_mapView addAnnotation:annotation];
        }];
}
- (IBAction)addRagent {
    SXQAddReagentExchangeController *addreagentVC = [[SXQAddReagentExchangeController alloc] initWithReagentExchangeTool:[self.service getReagentExchangeTool]];
    SXQNavgationController *nav = [[SXQNavgationController alloc] initWithRootViewController:addreagentVC];
    [self.service presentViewController:nav];
}
@end
