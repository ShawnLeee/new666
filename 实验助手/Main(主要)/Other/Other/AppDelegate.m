//
//  AppDelegate.m
//  实验助手
//
//  Created by SXQ on 15/8/30.
//  Copyright (c) 2015年 SXQ. All rights reserved.
//
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "SXQLoginController.h"
#import "DWLoginViewController.h"
#import <ShareSDK/ShareSDK.h>
#import <Parse/Parse.h>
#import "WeiboSDK.h"
#import "WXApi.h"
#import "AccountTool.h"
#import "Account.h"
#import "AppDelegate.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self p_setTabBarColor];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    if ([AccountTool account]) {//已登录
        [AppDelegate chooseRootController];
    }else
    {
        DWLoginViewController *loginVc = [[DWLoginViewController alloc] init];
        self.window.rootViewController = loginVc;
    }
    
    [self initializeSDK:launchOptions];
    return YES;
}
+ (void)chooseRootController
{
    NSString *key = @"CFBundleVersion";
    
    // 取出沙盒中存储的上次使用软件的版本号
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *lastVersion = [defaults stringForKey:key];
    
    // 获得当前软件的版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    if ([currentVersion isEqualToString:lastVersion]) {
        // 显示状态栏
        [UIApplication sharedApplication].statusBarHidden = NO;
        UIViewController *rootVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]
                                    instantiateViewControllerWithIdentifier:@"MainTabbarController"];
        [UIApplication sharedApplication].keyWindow.rootViewController = rootVC;
    } else { // 新版本
        UIViewController *rootVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]
                                    instantiateViewControllerWithIdentifier:@"MainTabbarController"];
        [UIApplication sharedApplication].keyWindow.rootViewController = rootVC;
        // 存储新版本
        [defaults setObject:currentVersion forKey:key];
        [defaults synchronize];
    }
}
- (void)p_setTabBarColor
{
    UIColor *normalColor = [UIColor colorWithRed:0.59 green:0.59 blue:0.59 alpha:1.0];
    UIColor *selectedColor = [UIColor colorWithRed:0.09 green:0.64 blue:0.70 alpha:1.0];
    [[UITabBar appearance] setTintColor:selectedColor];
    [[UIBarButtonItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : normalColor} forState:UIControlStateDisabled];
    [[UIBarButtonItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : selectedColor} forState:UIControlStateHighlighted ];
}
- (void)initializeSDK:(NSDictionary *)launchOptions
{
    [ShareSDK registerApp:@"a49a0b112fc0"];
    [Parse setApplicationId:@"CvNR2CTp1WFQV0JBZbAwJxlLJN7fQ9wHlN60izKI" clientKey:@"RRQMOVRAr5iEgToCkLEdMSM9VOn5ouoPMdGnpvbm"];
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    [self initializeVenderPlatform];
}
- (void)initializeVenderPlatform
{
    [ShareSDK connectSinaWeiboWithAppKey:@"1025145242" appSecret:@"2e264190d37e5d99382a4f30de539b4f" redirectUri:@"http://www.vocabulary.com/"];
    [ShareSDK connectWeChatWithAppId:@"wx4868b35061f87885"
                           appSecret:@"64020361b8ec4c99936c0e3999a9f249"
                           wechatCls:[WXApi class]];
    [ShareSDK connectSMS];
    //连接邮件
    [ShareSDK connectMail];
    
    //连接打印
    [ShareSDK connectAirPrint];
    
    //连接拷贝
    [ShareSDK connectCopy];
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:notification.alertBody delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [[alert rac_buttonClickedSignal]
     subscribeNext:^(id x) {
         application.applicationIconBadgeNumber = 0;
     }];
    [alert show];
}
- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    
}
@end
