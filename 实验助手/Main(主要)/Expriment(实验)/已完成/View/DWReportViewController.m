//
//  DWReportViewController.m
//  实验助手
//
//  Created by sxq on 15/11/23.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "UIBarButtonItem+SXQ.h"
#import "DWReportViewController.h"

@interface DWReportViewController ()<NSURLConnectionDataDelegate>
@property (nonatomic,weak) IBOutlet UIWebView *webView;
@property (nonatomic,copy) NSString *reportURLStr;
@end

@implementation DWReportViewController
- (instancetype)initWithReportURLStr:(NSString *)reportURLStr
{
    if (self = [super init]) {
        self.reportURLStr = reportURLStr;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self p_setupSelf];
    
    NSURL *url = [NSURL URLWithString:self.reportURLStr];
    NSData *data = [NSData dataWithContentsOfURL:url];
    [self.webView loadData:data MIMEType:@"application/pdf" textEncodingName:@"gb2312" baseURL:url];
}
- (void)p_setupSelf
{
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTitle:@"关闭" action:^{
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
}
@end
