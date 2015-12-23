//
//  DWReagentExchangeToolImpl.m
//  实验助手
//
//  Created by sxq on 15/12/1.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "SXQHttpTool.h"
#import <MJExtension/MJExtension.h>
#import "SXQAdjacentUserParam.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "DWReagentExchangeToolImpl.h"
#import "SXQAdjacentResult.h"
#import "SXQAdjacentUser.h"
#import "SXQReagentAnnotation.h"
@interface DWSetReagentParam:SXQBaseParam
@property (nonatomic,copy) NSString *reagent;
@end
@implementation DWSetReagentParam
@end

@implementation DWReagentExchangeToolImpl
- (RACSignal *)adjacentUserSignalWith:(SXQAdjacentUserParam *)param
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [SXQHttpTool getWithURL:AdjacentReagentURL params:param.keyValues success:^(id json) {
            if([json[@"code"] isEqualToString:@"1"])
            {
                SXQAdjacentResult *result = [SXQAdjacentResult objectWithKeyValues:json[@"data"]];
                NSArray *annotations = [self p_annotationsWithAdjacentUsers:result];
                [subscriber sendNext:annotations];
                [subscriber sendCompleted];
            }
            else
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
- (NSArray *)p_annotationsWithAdjacentUsers:(SXQAdjacentResult *)result
{
    __block NSMutableArray *tmpArray = [NSMutableArray array];
    
    SXQReagentAnnotation *meAnnotation = [SXQReagentAnnotation reagentAnnotationWithUser:result];
    [tmpArray addObject:meAnnotation];
    
    [result.arounds enumerateObjectsUsingBlock:^(SXQAdjacentUser *adjacentUser, NSUInteger idx, BOOL * _Nonnull stop) {
        SXQReagentAnnotation *annotation = [SXQReagentAnnotation reagentAnnotationWithUser:adjacentUser];
        [tmpArray addObject:annotation];
    }];
    return [tmpArray copy];
}
- (RACSignal *)setReagentWithReagentName:(NSString *)reagentName
{
    DWSetReagentParam *param = [DWSetReagentParam new];
    param.reagent = reagentName;
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [SXQHttpTool getWithURL:SetReagentURL params:param.keyValues success:^(id json) {
            [subscriber sendNext:@([json[@"code"] isEqualToString:@"1"])];
            [subscriber sendCompleted];
        } failure:^(NSError *error) {
            [subscriber sendError:error];
        }];
        return nil;
    }];
}
@end
