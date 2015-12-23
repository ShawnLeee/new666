//
//  DWBBSTopicResult.h
//  实验助手
//
//  Created by sxq on 15/12/3.
//  Copyright © 2015年 SXQ. All rights reserved.
//
@class DWBBSTopic;
#import <Foundation/Foundation.h>

@interface DWBBSTopicResult : NSObject
@property (nonatomic,strong) DWBBSTopic *topic;
@property (nonatomic,strong) NSArray *reviews;
@end
