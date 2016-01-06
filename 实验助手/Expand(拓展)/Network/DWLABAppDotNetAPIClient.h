//
//  DWLABAppDotNetAPIClient.h
//  实验助手
//
//  Created by sxq on 16/1/6.
//  Copyright © 2016年 SXQ. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface DWLABAppDotNetAPIClient : AFHTTPRequestOperationManager
+ (instancetype)sharedClient;
@end
