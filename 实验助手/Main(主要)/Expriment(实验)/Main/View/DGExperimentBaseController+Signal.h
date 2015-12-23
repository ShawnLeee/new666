//
//  DGExperimentBaseController+Signal.h
//  实验助手
//
//  Created by sxq on 15/10/26.
//  Copyright © 2015年 SXQ. All rights reserved.
//

#import "DGExperimentBaseController.h"

@interface DGExperimentBaseController (Signal)<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
- (RACSignal *)isChoosingSignal;
- (RACSignal *)isAddReagentLocation;
- (RACSignal *)suspendTimerSignal;
- (void)addReagentLocation;
- (RACSignal *)isTimingSignal;
- (void)choosePhotoOrigin;
- (void)addRemark;
@end
