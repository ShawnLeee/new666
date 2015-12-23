//
//  DWMeEditCell.m
//  实验助手
//
//  Created by sxq on 15/11/26.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "DWUserInfoViewModel.h"
#import "DWMeEditCell.h"
@interface DWMeEditCell ()
@property (nonatomic,weak) IBOutlet UILabel *itemLabel;
@property (nonatomic,weak) IBOutlet UITextField *inputField;
@end
@implementation DWMeEditCell
- (void)setViewModel:(DWUserInfoViewModel *)viewModel
{
    _viewModel = viewModel;
    self.inputField.delegate = viewModel;
    self.itemLabel.text = viewModel.title;
    self.inputField.text = viewModel.text;
   
    if(viewModel.shouldBeginEditing)
    {
        RAC(viewModel,text) = self.inputField.rac_textSignal;
    }else
    {
        @weakify(self)
        [RACObserve(self.viewModel, text)
         subscribeNext:^(NSString *text) {
             @strongify(self)
             self.inputField.text = text;
        }];     
    }
   
}
@end
