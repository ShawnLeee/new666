//
//  DWInstructionContainer.m
//  实验助手
//
//  Created by sxq on 15/12/9.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "SXQExpSubCategory.h"
#import "DWSubCategoryDelegate.h"
#import "MBProgressHUD+MJ.h"
#import "DWCategoryDelegate.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "DWInstructionContainer.h"
#import "DWAddExpInstruction.h"
#import <ActionSheetCustomPicker.h>
#import "SXQExpCategory.h"
@interface DWInstructionContainer ()<UITextFieldDelegate>
@property (nonatomic,weak) IBOutlet UITextField *categoryField;
@property (nonatomic,weak) IBOutlet UITextField *subCategoryField;
@property (nonatomic,weak) IBOutlet UITextField *instructionName;
@property (nonatomic,weak) IBOutlet UITextView *instructionDescView;
@property (nonatomic,weak) IBOutlet UITextView *instructionTheoryView;
@property (nonatomic,strong) MBProgressHUD *hud;
@end
@implementation DWInstructionContainer
- (void)setInstructionViewModel:(DWAddExpInstruction *)instructionViewModel
{
    _instructionViewModel = instructionViewModel;
    self.categoryField.text = instructionViewModel.expCategoryName;
    self.subCategoryField.text = instructionViewModel.expSubCategoryName;
    self.instructionName.text = instructionViewModel.experimentName;
    self.instructionDescView.text = instructionViewModel.experimentDesc;
    self.instructionTheoryView.text = instructionViewModel.experimentTheory;
    [self bindingModel];
}
- (void)bindingModel
{
    RAC(_instructionViewModel,experimentName) = self.instructionName.rac_textSignal;
    RAC(_instructionViewModel,experimentDesc) = self.instructionDescView.rac_textSignal;
    RAC(_instructionViewModel,experimentTheory) = self.instructionTheoryView.rac_textSignal;
    RAC(_instructionViewModel,expCategoryName) = self.categoryField.rac_textSignal;
    RAC(_instructionViewModel,expSubCategoryName) = self.subCategoryField.rac_textSignal;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if([textField isEqual:self.categoryField])
    {
        [self showFirstCategory:textField];
    }else if([textField isEqual:self.subCategoryField])
    {
        [self showSecondCategory:textField];
    }
    return NO;
}
- (void)showFirstCategory:(UITextField *)textField
{
    @weakify(self)
    [[[self.addInstructionService firstCategorySignal]
     doNext:^(id x) {
         @strongify(self)
        self.hud = [MBProgressHUD showMessage:nil];
     }]
    subscribeNext:^(NSArray *categories) {
         @strongify(self)
        [self.hud hide:YES];
        [self showFirstCategoryWithCategores:categories origin:textField];
    }];
    
}
- (void)showFirstCategoryWithCategores:(NSArray *)categories origin:(id)origin
{
    DWCategoryDelegate *categoryDelegate = [[DWCategoryDelegate alloc] initWithDoneBlock:^(SXQExpCategory *expCategory)
                                                                                {
                                                                                    self.categoryField.text = expCategory.expCategoryName;
                                                                                    self.instructionViewModel.expCategoryID = expCategory.expCategoryID;
                                                                                    self.subCategoryField.text = nil;
                                                                                    self.instructionViewModel.expSubCategoryID = nil;
                                                                                }
                                                                     cancelBlock:^{
        
                                                                                    }
                                                                      categories:categories];
    [ActionSheetCustomPicker showPickerWithTitle:@"选择一级分类"
                                      delegate:categoryDelegate
                              showCancelButton:YES
                                        origin:origin];
}
- (void)showSecondCategory:(UITextField *)textField
{
    if (!self.instructionViewModel.expCategoryID) {
        [MBProgressHUD showError:@"请先选择一级分类"];
        return;
    }
    @weakify(self)
    [[[self.addInstructionService secondCategorySignalWithCategoryID:self.instructionViewModel.expCategoryID]
    doNext:^(id x) {
        @strongify(self)
        self.hud = [MBProgressHUD showMessage:nil];
    }]
    subscribeNext:^(NSArray *subCategories) {
        @strongify(self)
        [self.hud hide:YES];
        [self showSubCategoryWithCategories:subCategories origin:textField];
    }];
}
- (void)showSubCategoryWithCategories:(NSArray *)subCategories origin:(id)origin
{
    DWSubCategoryDelegate *subDelegate = [[DWSubCategoryDelegate alloc] initWithDoneBlock:^(SXQExpSubCategory *expSubCategory) {
        self.subCategoryField.text = expSubCategory.expSubCategoryName;
        self.instructionViewModel.expSubCategoryID = expSubCategory.expSubCategoryID;
    } cancelBlock:^{
        
    } categories:subCategories];
    
    [ActionSheetCustomPicker showPickerWithTitle:@"选择二级分类" delegate:subDelegate showCancelButton:YES origin:origin];
}
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView isEqual:self.instructionDescView]) {
        [self setInstroductionView:textView];
    }else
    {
        [self setTheoryView:textView];
    }
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([textView isEqual:self.instructionDescView]) {
        [self setInstroductionView:textView];
    }else
    {
        [self setTheoryView:textView];
    }
}
- (void)setInstroductionView:(UITextView *)introductionView
{
    if ([introductionView.text isEqualToString:@"请输入实验简介"]) {
        introductionView.text = @"";
        introductionView.textColor = [UIColor whiteColor]; //optional
        [introductionView becomeFirstResponder];
        return;
    }
    if ([introductionView.text isEqualToString:@""]) {
        introductionView.text = @"请输入实验简介";
        introductionView.textColor = [UIColor lightGrayColor]; //optional
        [introductionView  resignFirstResponder];
    }
}
- (void)setTheoryView:(UITextView *)theoryView
{
    if ([theoryView.text isEqualToString:@"请输入实验原理"]) {
        theoryView.text = @"";
        theoryView.textColor = [UIColor whiteColor]; //optional
        [theoryView becomeFirstResponder];
        return;
    }
    if ([theoryView.text isEqualToString:@""]) {
        theoryView.text = @"请输入实验原理";
        theoryView.textColor = [UIColor lightGrayColor]; //optional
        [theoryView  resignFirstResponder];
    }
}
@end
