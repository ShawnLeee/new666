//
//  SXQMeViewController.m
//  实验助手
//
//  Created by sxq on 15/9/10.
//  Copyright (c) 2015年 SXQ. All rights reserved.
//
#import "SXQLoginViewController.h"
#import "SXQMeViewController.h"
#import "SXQVenderLogin.h"
#import "UIBarButtonItem+SXQ.h"
#import "SXQSettingController.h"
@interface SXQMeViewController ()

@end

@implementation SXQMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self p_setNav];
}
- (void)p_setNav
{
//    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTitle:@"设置" action:^{
//        [self.navigationController pushViewController:[SXQSettingController new] animated:YES];
//    }];
}

- (IBAction)login:(UIButton *)sender {
    UIViewController *vc = [SXQLoginViewController new];
    [self.navigationController pushViewController:vc animated:YES];

}

@end
