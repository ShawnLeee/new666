//
//  DWInstructionCell.m
//  实验助手
//
//  Created by sxq on 15/11/18.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "SXQExpSubCategory.h"
#import "DWInstructionCell.h"
@interface DWInstructionCell ()
@property (nonatomic,weak) IBOutlet UILabel *subCategoryLabel;
@end
@implementation DWInstructionCell

- (void)awakeFromNib {
    // Initialization code
}
- (void)setSubCategory:(SXQExpSubCategory *)subCategory
{
    _subCategory = subCategory;
    self.subCategoryLabel.text = subCategory.expSubCategoryName;
}
@end
