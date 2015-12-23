//
//  DWAcademicService.h
//  实验助手
//
//  Created by sxq on 15/10/28.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "DWAcademicTool.h"
#import "DWReagentExchangeTool.h"
#import "DWConsultTool.h"
#import "DWBBSTool.h"
#import <Foundation/Foundation.h>

@protocol DWAcademicService <NSObject>
- (id<DWAcademicTool>)getService;

- (id<DWBBSTool>)getBBSTool;
- (id<DWConsultTool>)getConsultTool;
- (id<DWReagentExchangeTool>)getReagentExchangeTool;
- (void)presentViewController:(UIViewController *)viewControllerToPresent;
@end
