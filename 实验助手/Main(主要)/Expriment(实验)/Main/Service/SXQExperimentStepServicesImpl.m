//
//  SXQExperimentStepServicesImpl.m
//  实验助手
//
//  Created by sxq on 15/10/23.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "SXQNavgationController.h"
#import "SXQRemarkController.h"
#import "UIBarButtonItem+SXQ.h"
#import "DGExperimentBaseController+Signal.h"
#import "SXQExperimentStepImpl.h"
#import "SXQExperimentStepServicesImpl.h"
#import "MBProgressHUD+MJ.h"
#import "CellContainerViewModel.h"
#import "SXQDBManager.h"
@interface SXQExperimentStepServicesImpl ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (nonatomic,strong) SXQExperimentStepImpl *service;
@property (nonatomic,weak) UINavigationController *navigationController;
@property (nonatomic,weak) DGExperimentBaseController *experimentController;
@end
@implementation SXQExperimentStepServicesImpl
- (DGExperimentBaseController *)experimentController
{
    if (!_experimentController) {
        _experimentController = (DGExperimentBaseController *)self.navigationController.topViewController;
    }
    return _experimentController;
}
- (instancetype)initWithNavigationController:(UINavigationController *)navigationController
{
    if (self = [super init]) {
        _navigationController = navigationController;
    }
    return self;
}
- (SXQExperimentStepImpl *)service
{
    if (!_service) {
        _service = [SXQExperimentStepImpl new];
    }
    return _service;
}
- (id<DWExperimentStep>)getServices
{
    return self.service;
}
- (RACSignal *)imagePickedSignal
{
    RACSignal *imageCancelSignal = [[self rac_signalForSelector:@selector(imagePickerControllerDidCancel:) fromProtocol:@protocol(UIImagePickerControllerDelegate)]
    map:^id(RACTuple *tuple) {
        return tuple.first;
    }];
    
    RACSignal *imagePickedSignal =
    [[[self rac_signalForSelector:@selector(imagePickerController:didFinishPickingMediaWithInfo:)
                       fromProtocol:@protocol(UIImagePickerControllerDelegate)]
         map:^id(RACTuple *tuple) {
             UIImagePickerController *picker = tuple.first;
             [picker dismissViewControllerAnimated:YES completion:nil];
             return tuple.second;
         }]
         map:^id(NSDictionary *info) {
             return info[UIImagePickerControllerOriginalImage];
         }];
    
    RACSignal *imageSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        UIAlertController *alertCon = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"从相册选一张" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self openPhotoLibrary];
        }];
        UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"拍一张" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self openCamera];
        }];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [subscriber sendNext:nil];
            [subscriber sendCompleted];
            }];
        
        [alertCon addAction:photoAction];
        [alertCon addAction:cameraAction];
        [alertCon addAction:cancelAction];
        [self.navigationController presentViewController:alertCon animated:YES completion:nil];
        
        //ImagePicker clicked cancel
        [imageCancelSignal subscribeNext:^(UIViewController *imageVC) {
            [imageVC dismissViewControllerAnimated:YES completion:^{
                [subscriber sendNext:nil];
                [subscriber sendCompleted];
            }];
        }];
        [imagePickedSignal subscribeNext:^(UIImage *image) {
            [subscriber sendNext:image];
            [subscriber sendCompleted];
        }];
        return nil;
    }];
    return imageSignal;
}
/**
 *  打开相机
 */
- (void)openCamera
{
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
    ipc.delegate = self;
    [self.experimentController presentViewController:ipc animated:YES completion:nil];
}
/**
 *  打开相册
 */
- (void)openPhotoLibrary
{
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTitle:@"ddddd" action:^{
        
    }];
    ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    ipc.delegate = self;
    [self.experimentController presentViewController:ipc animated:YES completion:nil];
}
- (RACSignal *)remarkAddSignalWithViewModel:(CellContainerViewModel *)viewModel
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        SXQRemarkController *remarkVC =  [[SXQRemarkController alloc] initWithViewModel:viewModel completion:^{
            [subscriber sendNext:viewModel];
            [subscriber sendCompleted];
        }];
        SXQNavgationController *nav = [[SXQNavgationController alloc] initWithRootViewController:remarkVC];
        [self.experimentController presentViewController:nav animated:YES completion:nil];
        return nil;
    }];
}
- (RACSignal *)launchSignalWithViewModel:(CellContainerViewModel *)viewModel
{
    return [self.experimentController launchSignalWithModel:viewModel];
}
- (RACSignal *)setCompleteWithMyExpId:(NSString *)myExpId
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        BOOL success = [[SXQDBManager sharedManager] fulfillExperimentWithMyExpId:myExpId];
        [subscriber sendNext:@(success)];
        [subscriber sendCompleted];
        return nil;
    }];
}
- (void)activeAllStep
{
    [self.experimentController dg_activeAllStep];
}
@end
