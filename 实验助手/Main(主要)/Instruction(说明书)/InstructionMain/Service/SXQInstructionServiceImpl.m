//
//  SXQSearchServiceImpl.m
//  实验助手
//
//  Created by sxq on 15/10/29.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "DWSubInstructionController.h"
#import "SXQExpCategoryViewModel.h"
#import <MJExtension/MJExtension.h>
#import "SXQInstructionServiceImpl.h"
#import "SXQInstructionSearchImpl.h"
#import "SXQExpInstruction.h"
#import "SXQInstructionDetailController.h"
#import "SXQExpCategory.h"
#import "SXQExpSubCategory.h"
#import "SXQHttpTool.h"
@interface SXQInstructionServiceImpl ()
@property (nonatomic,strong) SXQInstructionSearchImpl *service;
@property (nonatomic,weak) UINavigationController *navigationController;
@end
@implementation SXQInstructionServiceImpl
- (instancetype)initWithNavigationController:(UINavigationController *)nav
{
    if (self = [super init]) {
        _navigationController = nav;
    }
    return self;
}
- (SXQInstructionSearchImpl *)service
{
    if (_service == nil) {
        _service = [[SXQInstructionSearchImpl alloc] init];
    }
    return _service;
}
- (id<SXQInstructionSearch>)getService
{
    return self.service;
}
- (RACSignal *)instructionCategorySignal
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [SXQHttpTool getWithURL:InstructionMainURL params:nil success:^(id json) {
            if ([json[@"code"] isEqualToString:@"1"]) {
                NSArray *resultArray = [SXQExpCategory objectArrayWithKeyValuesArray:json[@"data"]];
                NSArray *viewModelArray = [self p_convertToViewModelWihtModelArray:resultArray];
                [subscriber sendNext:viewModelArray];
                [subscriber sendCompleted];
            }else
            {
                [subscriber sendNext:nil];
                [subscriber sendCompleted];
            }
        } failure:^(NSError *error) {
            [subscriber sendError:error];
        }];
        return nil;
    }];
}
- (NSArray *)p_convertToViewModelWihtModelArray:(NSArray *)modelArray
{
    __block NSMutableArray *tmpArray = [@[] mutableCopy];
    [modelArray enumerateObjectsUsingBlock:^(SXQExpCategory *expcategory, NSUInteger idx, BOOL * _Nonnull stop) {
        SXQExpCategoryViewModel *viewModel = [[SXQExpCategoryViewModel alloc] initWithExpCategory:expcategory service:self];
        [tmpArray addObject:viewModel];
    }];
    return [tmpArray copy];
}
- (void)pushViewModel:(id)viewModel
{
    if ([viewModel isKindOfClass:[SXQExpCategoryViewModel class]]) {
        [self p_pushExpCategoryViewModel:viewModel];
    }
}
- (void)p_pushExpCategoryViewModel:(SXQExpCategoryViewModel *)viewModel
{
    DWSubInstructionController *subVc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]
                                         instantiateViewControllerWithIdentifier:NSStringFromClass([DWSubInstructionController class])];
    subVc.viewModel = viewModel;
    subVc.service = self;
    
    [self.navigationController pushViewController:subVc animated:YES];
}
- (RACSignal *)subcategoryWithCategoryID:(NSString *)categoryId
{
    NSDictionary *param = @{@"expCategoryID" : categoryId};
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [SXQHttpTool getWithURL:SubExpURL params:param success:^(id json) {
            if ([json[@"code"] isEqualToString:@"1"]) {
                NSArray *subcategories = [SXQExpSubCategory objectArrayWithKeyValuesArray:json[@"data"]];
                [subscriber sendNext:subcategories];
                [subscriber sendCompleted];
            }else
            {
                [subscriber sendNext:nil];
                [subscriber sendCompleted];
            }
            
        } failure:^(NSError *error) {
            [subscriber sendError:error];
        }];
        return nil;
    }];
}
@end
