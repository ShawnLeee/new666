//
//  DWBBSModuleCell.m
//  实验助手
//
//  Created by sxq on 15/12/1.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "DWBBSModel.h"
#import "DWBBSModuleCell.h"
@interface DWBBSModuleCell ()
@property (nonatomic,weak) IBOutlet UILabel *moduleNameLabel;
@end
@implementation DWBBSModuleCell
- (void)setBbsModel:(DWBBSModel *)bbsModel
{
    _bbsModel = bbsModel;
    self.moduleNameLabel.text = bbsModel.moduleName;
}
- (void)awakeFromNib {
    // Initialization code
}

@end
