//
//  DWAcademicServiceImpl.m
//  实验助手
//
//  Created by sxq on 15/10/28.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "DWBBSToolImpl.h"
#import "DWConsultToolImpl.h"
#import "DWReagentExchangeToolImpl.h"
#import "DWAcademicToolImpl.h"
#import "DWAcademicServiceImpl.h"
@interface DWAcademicServiceImpl ()
@property (nonatomic,weak) UINavigationController *navigationController;
@property (nonatomic,strong) DWAcademicToolImpl *service;

@property (nonatomic,strong) id<DWBBSTool> bbsTool;
@property (nonatomic,strong) id<DWConsultTool> consultTool;
@property (nonatomic,strong) id<DWReagentExchangeTool> reagentExchangeTool;
@end
@implementation DWAcademicServiceImpl
- (instancetype)initWithNavigationController:(UINavigationController *)navgationController
{
    if (self = [super init]) {
        _navigationController = navgationController;
    }
    return self;
}
- (DWAcademicToolImpl *)service
{
    if (_service == nil) {
        _service = [DWAcademicToolImpl new];
    }
    return _service;
}
- (id<DWAcademicTool>)getService
{
    return self.service;
}
- (id<DWBBSTool>)bbsTool
{
    if (!_bbsTool) {
        _bbsTool = [[DWBBSToolImpl alloc] initWithNavigationController:self.navigationController];
    }
    return _bbsTool;
}
- (id<DWConsultTool>)consultTool
{
    if (!_consultTool) {
        _consultTool = [[DWConsultToolImpl alloc] init];
    }
    return _consultTool;
}
- (id<DWReagentExchangeTool>)reagentExchangeTool
{
    if (!_reagentExchangeTool) {
        _reagentExchangeTool = [[DWReagentExchangeToolImpl alloc] init];
    }
    return _reagentExchangeTool;
}
- (id<DWBBSTool>)getBBSTool
{
    return self.bbsTool;
}
- (id<DWConsultTool>)getConsultTool
{
    return self.consultTool;
}
- (id<DWReagentExchangeTool>)getReagentExchangeTool
{
    return self.reagentExchangeTool;
}
- (void)presentViewController:(UIViewController *)viewControllerToPresent
{
    [self.navigationController presentViewController:viewControllerToPresent animated:YES completion:nil];
}
@end
