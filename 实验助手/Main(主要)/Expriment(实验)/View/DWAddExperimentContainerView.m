//
//  DWAddExperimentContainerView.m
//  实验助手
//
//  Created by sxq on 15/12/25.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "SXQExpInstruction.h"
#import "DWAddExperimentContainerView.h"
@interface DWAddExperimentContainerView ()
@property (nonatomic,weak) IBOutlet UILabel *experimentNameLabel;
@property (nonatomic,weak) IBOutlet UILabel *experimentDescLabel;
@property (nonatomic,weak) IBOutlet UILabel *experimentTheoryLabel;
@property (nonatomic,weak) IBOutlet UILabel *experimentcategoryLabel;
@property (nonatomic,weak) IBOutlet UILabel *experimentsubcategoryLabel;

@end
@implementation DWAddExperimentContainerView
- (void)setExpInstruction:(SXQExpInstruction *)expInstruction
{
    _expInstruction = expInstruction;
    self.experimentNameLabel.text = expInstruction.experimentName;
    self.experimentDescLabel.text = expInstruction.experimentDesc;
    self.experimentTheoryLabel.text = expInstruction.experimentTheory;
    self.experimentcategoryLabel.text = expInstruction.expCategoryName;
    self.experimentsubcategoryLabel.text = expInstruction.expSubCategoryName;
}
@end
