//
//  SXQLoginViewModelServiceImpl.m
//  实验助手
//
//  Created by sxq on 15/10/22.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "DWForgetPassController.h"
#import "SXQLoginImpl.h"
#import "SXQLoginViewModelServiceImpl.h"
@interface SXQLoginViewModelServiceImpl ()
@property (nonatomic,strong) SXQLoginImpl *service;
@property (nonatomic,weak) UINavigationController *navigationController;
@end

@implementation SXQLoginViewModelServiceImpl
- (instancetype)initWithNavigationController:(UINavigationController *)nav
{
    if (self = [super init]) {
        _navigationController = nav;
    }
    return self;
}
- (SXQLoginImpl *)service
{
    if (!_service) {
        _service = [[SXQLoginImpl alloc] init];
    }
    return _service;
}

- (id<SXQLogin>)getService
{
    return self.service;
}
- (void)pushViewModel:(id)viewModel
{
    DWForgetPassController *forgetPassVC = [[DWForgetPassController alloc] initWithLoginTool:[self getService]];
    [self.navigationController pushViewController:forgetPassVC animated:YES];
}
@end
