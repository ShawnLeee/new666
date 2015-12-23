//
//  DWConsultDetailController.m
//  实验助手
//
//  Created by sxq on 15/10/28.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "DWNews.h"
#import "DWConsultDetailController.h"

@interface DWConsultDetailController ()
@property (nonatomic,strong) DWNews *news;
@property (nonatomic,weak) IBOutlet UIWebView *webView;
@end

@implementation DWConsultDetailController
- (instancetype)initWithNews:(DWNews *)news
{
    if (self = [super init]) {
        _news = news;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.news.content;
    NSURL *url = [NSURL URLWithString:self.news.url];
    NSURLRequest *request =  [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}
@end
