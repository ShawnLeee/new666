//
//  DWBBSTopicController.h
//  实验助手
//
//  Created by sxq on 15/12/7.
//  Copyright © 2015年 SXQ. All rights reserved.
//
@class DWBBSTopic;
#import <UIKit/UIKit.h>
#import "DWBBSTool.h"
@interface DWBBSTopicController : UIViewController
- (instancetype)initWithBBSTopic:(DWBBSTopic *)bbsTopic bbsTool:(id<DWBBSTool>)bbsTool;
@end
