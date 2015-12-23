//
//  SXQReportCell.m
//  实验助手
//
//  Created by sxq on 15/11/10.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "SXQReportViewModel.h"
#import "SXQReportCell.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
@interface SXQReportCell ()
@property (nonatomic,weak) IBOutlet UIButton *downLoadBtn;
@property (nonatomic,weak) IBOutlet UILabel *reportNameLabel;
@end
@implementation SXQReportCell
+ (NSString *)cellIdentifier
{
    return NSStringFromClass(self);
}
- (void)setViewModel:(SXQReportViewModel *)viewModel
{
    _viewModel = viewModel;
    [self bindingViewModel];
}
- (void)bindingViewModel
{
    self.reportNameLabel.text = self.viewModel.reportName;
    
    [RACObserve(self.viewModel, buttonImageName)
     subscribeNext:^(NSString *imageName) {
         UIImage *image = [UIImage imageNamed:imageName];
         [self.downLoadBtn setImage:image forState:UIControlStateNormal];
    }];
    
    self.downLoadBtn.rac_command = self.viewModel.downloadCommand;
//    RAC(self.downLoadBtn,hidden) = [[self.viewModel.downloadCommand.executing takeUntil:self.rac_prepareForReuseSignal] delay:3];
}
@end
