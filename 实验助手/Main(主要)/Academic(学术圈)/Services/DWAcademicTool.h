//
//  DWAcademicTool.h
//  实验助手
//
//  Created by sxq on 15/10/28.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <Foundation/Foundation.h>

@protocol DWAcademicTool <NSObject>
- (RACSignal *)newsSignal;
@end
