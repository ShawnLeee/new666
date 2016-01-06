//
//  DWLABAppDotNetAPIClient.m
//  实验助手
//
//  Created by sxq on 16/1/6.
//  Copyright © 2016年 SXQ. All rights reserved.
//
#import "DWLABAppDotNetAPIClient.h"

//#define LAB_APP_BASE_URL @"http://hualang.wicp.net:8090/LabAssistant/"
//#define LAB_APP_BASE_URL @"http://127.0.0.1:9090/LabAssistant/"
//#define LAB_APP_BASE_URL @"http://172.18.1.55:8080/LabAssistant/"
#define LAB_APP_BASE_URL @"http://139.196.194.0:9090/LabAssistant/"

static NSString * const DWLABAPPDotNetAPIBaseURLString = LAB_APP_BASE_URL;

@implementation DWLABAppDotNetAPIClient
+ (instancetype)sharedClient
{
    static DWLABAppDotNetAPIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[DWLABAppDotNetAPIClient alloc] initWithBaseURL:[NSURL URLWithString:DWLABAPPDotNetAPIBaseURLString]];
    });
    return _sharedClient;
}
@end
