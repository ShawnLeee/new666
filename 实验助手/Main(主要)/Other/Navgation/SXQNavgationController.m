//
//  SXQNavgationController.m
//  实验助手
//
//  Created by SXQ on 15/8/30.
//  Copyright (c) 2015年 SXQ. All rights reserved.
//
#import "UIBarButtonItem+MJ.h"
#import "SXQNavgationController.h"

@interface SXQNavgationController ()

@end

@implementation SXQNavgationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
+ (void)initialize
{
    UINavigationBar *navbarAppearance = [UINavigationBar appearance];
//    navbarAppearance.barTintColor = [UIColor colorWithRed:0.29 green:0.47 blue:0.78 alpha:1.0];
    navbarAppearance.tintColor = [UIColor colorWithRed:0.24 green:0.24 blue:0.26 alpha:1.0];
    navbarAppearance.translucent = NO;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithIcon:@"icon_back" highIcon:@"icon_back" target:self action:@selector(back)];
//        viewController.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithIcon:@"navigationbar_more" highIcon:@"navigationbar_more_highlighted" target:self action:@selector(more)];
        
    }
    [super pushViewController:viewController animated:animated];
}

- (void)more
{
    [self popToRootViewControllerAnimated:YES];
}

- (void)back
{
    [self popViewControllerAnimated:YES];
}
//- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
//{
//    viewController.hidesBottomBarWhenPushed = YES;
////    viewController.view.window.backgroundColor = [UIColor whiteColor];
//    [super pushViewController:viewController animated:YES];
//}
- (void)setViewControllers:(NSArray<UIViewController *> *)viewControllers animated:(BOOL)animated
{
    [super setViewControllers:viewControllers animated:animated];
}
@end
