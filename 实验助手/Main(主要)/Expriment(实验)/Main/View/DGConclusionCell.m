//
//  DGConclusionCell.m
//  实验助手
//
//  Created by sxq on 16/1/8.
//  Copyright © 2016年 SXQ. All rights reserved.
//
#import "PhotoContainer.h"
#import "DGConclusionCell.h"
#import "DGConclusionViewModel.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
@interface DGConclusionCell ()
@property (weak, nonatomic) IBOutlet UITextView *conclusionView;
@property (weak, nonatomic) IBOutlet PhotoContainer *photoContainer;
@property (nonatomic,weak) IBOutlet NSLayoutConstraint *photoHeightConstraint;
@end
@implementation DGConclusionCell
- (void)awakeFromNib
{
    [self.conclusionView becomeFirstResponder];
}
- (void)setViewModel:(DGConclusionViewModel *)viewModel
{
    _viewModel = viewModel;
    self.conclusionView.text = viewModel.conclusionText;
    
    
    self.photoContainer.conculusionModel = viewModel;
    @weakify(self)
    [RACObserve(self.viewModel, images) subscribeNext:^(NSMutableArray *images) {
        @strongify(self)
        CGSize photoSize = [PhotoContainer photosViewSizeWithPhotosCount:images.count];
        self.photoHeightConstraint.constant = photoSize.height;
    }];
    [self.conclusionView.rac_textSignal subscribeNext:^(NSString *conclusionText) {
        @strongify(self)
        self.viewModel.conclusionText = conclusionText;
    }];
}
@end
