//
//  DWBBSModel.h
//  实验助手
//
//  Created by sxq on 15/12/1.
//  Copyright © 2015年 SXQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DWBBSModel : NSObject
@property (nonatomic,copy) NSString *moduleID;
@property (nonatomic,copy) NSString *moduleImgPath;
@property (nonatomic,copy) NSString *moduleName;
@property (nonatomic,assign) BOOL allowShow;
@end
