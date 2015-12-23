//
//  SXQPdfController.h
//  实验助手
//
//  Created by sxq on 15/11/10.
//  Copyright © 2015年 SXQ. All rights reserved.
//
@class SXQReportViewModel;
#import <UIKit/UIKit.h>

@interface SXQPdfController : UIViewController<UIDocumentInteractionControllerDelegate>
- (instancetype)initWithReportViewModel:(SXQReportViewModel *)viewModel;
@end
