//
//  SXQExpStep.m
//  实验助手
//
//  Created by sxq on 15/10/9.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "SXQDBManager.h"
#import "SXQExpStep.h"
#import <MJExtension/MJExtension.h>
//static const NSUInteger kImageCount = 9;
@interface SXQExpStep ()
@end
@implementation SXQExpStep
+ (NSDictionary *)objectClassInArray
{
    return @{@"images" : [UIImage class]};
}
- (NSMutableArray *)images
{
    if (_images == nil) {
        _images = [NSMutableArray array];
    }
    return _images;
}
- (NSString *)processMemo
{
    if ([_processMemo isEqualToString:@"(null)"]) {
        return @"";
    }
    return _processMemo;
}
- (void)saveProcessMemo:(NSString *)processMemo
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"CellRefreshContent" object:self];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        _processMemo = [processMemo copy];
        [[SXQDBManager sharedManager] updateMyExpProcessMemoWithExpProcessID:_myExpProcessId
                                                                 processMemo:_processMemo];
    });
}
- (void)addImage:(UIImage *)image myExpId:(NSString *)myExpId
{
    [self insertObject:image inImagesAtIndex:self.images.count];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"CellRefreshContent" object:self];
    //添加到数据库
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [[SXQDBManager sharedManager] addImageWithMyExpId:myExpId expInstructionId:_expInstructionID expStepId:_expStepID image:image];
    });
}
- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@ %p>,%@",[self class] ,self,@{@"processMemo" : _processMemo}];
}
- (void)insertObject:(UIImage *)object inImagesAtIndex:(NSUInteger)index
{
    [self.images insertObject:object atIndex:index];
}
- (void)removeObjectFromImagesAtIndex:(NSUInteger)index
{
    [self.images removeObjectAtIndex:index];
}

@end








