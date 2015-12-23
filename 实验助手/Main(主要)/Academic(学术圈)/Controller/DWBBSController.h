//
//  DWBBSController.h
//  实验助手
//
//  Created by sxq on 15/12/1.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "DWAcademicService.h"
#import <UIKit/UIKit.h>

@interface DWBBSController : UICollectionViewController
@property (nonatomic,strong) id<DWAcademicService> service;
@end
