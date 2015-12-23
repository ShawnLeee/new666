//
//  SXQPdfController.m
//  实验助手
//
//  Created by sxq on 15/11/10.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "SXQReportViewModel.h"
#import "SXQPdfController.h"

@interface SXQPdfController ()
@property (nonatomic,strong) SXQReportViewModel *viewModel;
@property (nonatomic,strong) UIDocumentInteractionController *documentInteractionController;
@end

@implementation SXQPdfController
- (instancetype)initWithReportViewModel:(SXQReportViewModel *)viewModel
{
    if (self = [super init]) {
        _viewModel = viewModel;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    NSString *samPath = [[NSBundle mainBundle] pathForResource:@"sample" ofType:@"pdf"];
//    NSURL *fileURL = [NSURL fileURLWithPath:samPath];
//    if (fileURL) {
//        // Initialize Document Interaction Controller
//        self.documentInteractionController = [UIDocumentInteractionController interactionControllerWithURL:fileURL];
//        
//        // Configure Document Interaction Controller
//        [self.documentInteractionController setDelegate:self];
//        
//        // Preview PDF
//            [self.documentInteractionController presentPreviewAnimated:YES];
//    }
//    // Do any additional setup after loading the view.
    [self p_setupWebView];
}


- (UIViewController *)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *)interactionController
{
    return self;
}

-(UIView *)documentInteractionControllerViewForPreview:(UIDocumentInteractionController *)controller{
    return self.view;
}

- (CGRect)documentInteractionControllerRectForPreview:(UIDocumentInteractionController*)controller
{
    return self.view.frame;
}

- (void)p_setupWebView
{
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    NSString *pdfFile = [self.viewModel.reportName stringByAppendingString:@".pdf"];
    NSString *filePath =  [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:pdfFile];
    filePath = [filePath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *fileURL = [NSURL URLWithString:filePath];
    NSURLRequest *request = [NSURLRequest requestWithURL:fileURL];
    [webView loadRequest:request];
    [self.view addSubview:webView];
}
-(NSString *)getDBPathPDf:(NSString *)PdfName {
    NSString *pdfFile = [PdfName stringByAppendingString:@".pdf"];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES);
    NSString *documentsDir = [paths objectAtIndex:0];
    return [documentsDir stringByAppendingPathComponent:pdfFile];
}
@end
