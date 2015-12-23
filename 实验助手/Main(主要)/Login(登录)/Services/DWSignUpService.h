//
//  DWSignUpService.h
//  实验助手
//
//  Created by sxq on 15/11/18.
//  Copyright © 2015年 SXQ. All rights reserved.
//
@class RACSignal;
#import <Foundation/Foundation.h>

@protocol DWSignUpService <NSObject>
- (RACSignal *)signUpModelsSignal;
- (RACSignal *)signUpWithGrouData:(NSArray *)groups;
- (void)dismissKeyBoard;
- (RACSignal *)schoolsSignal;
- (RACSignal *)professionsSingal;
- (void)enableAction;
- (void)disableAction;
@end
