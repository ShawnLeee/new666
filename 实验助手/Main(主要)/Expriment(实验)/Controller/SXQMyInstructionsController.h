//
//  SXQMyInstructionsController.h
//  实验助手
//
//  Created by sxq on 15/9/15.
//  Copyright (c) 2015年 SXQ. All rights reserved.
//

#import "DWGroup.h"
#import <UIKit/UIKit.h>
#import "SXQHotInstruction.h"
#import "SXQMyGenericInstruction.h"

typedef NS_ENUM(NSUInteger,SectionType){
    SectionTypeMyInstructionType = 0,
    SectionTypeHotInstructionType = 1,
};
@interface SXQMyInstructionsController : UITableViewController
@property (nonatomic,strong) NSArray *groups;
@end
