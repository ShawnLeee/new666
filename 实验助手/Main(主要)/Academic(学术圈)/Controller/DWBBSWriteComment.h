//
//  DWBBSWriteComment.h
//  实验助手
//
//  Created by sxq on 15/12/2.
//  Copyright © 2015年 SXQ. All rights reserved.
//
@class DWBBSCommentParam;
#import "DWBBSTool.h"
#import <UIKit/UIKit.h>

@interface DWBBSWriteComment : UIViewController
- (instancetype)initWithCommentParam:(DWBBSCommentParam *)param bbsTool:(id<DWBBSTool>)bbsTool;
@end
