//
//  DGConclusionViewModel.m
//  实验助手
//
//  Created by sxq on 16/1/8.
//  Copyright © 2016年 SXQ. All rights reserved.
//
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "DGConclusionViewModel.h"
@interface DGConclusionViewModel ()
@property (nonatomic,strong) id<SXQExperimentServices> servce;
@end
@implementation DGConclusionViewModel
- (NSMutableArray *)images
{
    if (!_images) {
        _images = [NSMutableArray array];
    }
    return _images;
}
- (instancetype)initWithService:(id<SXQExperimentServices>)service
{
    if (self = [super init]) {
        _servce = service;
        [self p_setupAddImageCmd];
    }
    return self;
}
- (void)p_setupAddImageCmd
{
    @weakify(self)
    _addImageCmd = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self)
        return [self.servce imagePickedSignal];
    }];
   [[[_addImageCmd.executionSignals switchToLatest] takeUntil:self.cell.rac_prepareForReuseSignal]
    subscribeNext:^(UIImage *image) {
        @strongify(self)
        if(image)
        {
            [self addImage:image];
            if (self.updateUIBlock) {
                self.updateUIBlock();
            }    
        }
        
    }];
}
- (void)insertObject:(UIImage *)object inImagesAtIndex:(NSUInteger)index
{
    [self.images insertObject:object atIndex:index];
}
- (void)removeObjectFromImagesAtIndex:(NSUInteger)index
{
    [self.images removeObjectAtIndex:index];
}
- (void)addImage:(UIImage *)image
{
    [self insertObject:image inImagesAtIndex:self.images.count];
    //添加到数据库
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        [[SXQDBManager sharedManager] addImageWithMyExpId:self.experimentStep.myExpId expInstructionId:self.experimentStep.expInstructionID expStepId:self.experimentStep.expStepID image:image];
//    });
}
@end
