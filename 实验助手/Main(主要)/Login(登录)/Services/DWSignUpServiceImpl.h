//
//  DWSignUpServiceImpl.h
//  实验助手
//
//  Created by sxq on 15/11/18.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "DWSignUpService.h"
#import <Foundation/Foundation.h>
@interface DWLocation : NSObject
@property (nonatomic,copy) NSString *provinceId;
@property (nonatomic,copy) NSString *cityID;
@end
@interface DWSignUpServiceImpl : NSObject<DWSignUpService>
- (instancetype)initWithTableView:(UITableView *)tabelView;
@property (nonatomic,strong) DWLocation *location;
@end
