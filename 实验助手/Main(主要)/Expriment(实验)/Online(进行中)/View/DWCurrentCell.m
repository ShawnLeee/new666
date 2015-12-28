//
//  DWCurrentCell.m
//  实验助手
//
//  Created by sxq on 15/12/24.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "DWCurrentViewModel.h"
#import "DWCurrentCell.h"
@interface DWCurrentCell ()
@property (nonatomic,weak) IBOutlet UILabel *nameLabel;
@property (nonatomic,weak) IBOutlet UILabel *stepTimeLabel;
@property (nonatomic,weak) IBOutlet UILabel *stepDescLabel;
@property (nonatomic,weak) IBOutlet UILabel *notesLabel;
@property (nonatomic,weak) IBOutlet UIImageView *stepIcon;
@end
@implementation DWCurrentCell

- (void)awakeFromNib {
    // Initialization code
}
- (void)setCurrentViewModel:(DWCurrentViewModel *)currentViewModel
{
    _currentViewModel = currentViewModel;
    self.nameLabel.text = currentViewModel.experimentName;
    self.stepTimeLabel.text = currentViewModel.timeStr;
    self.stepDescLabel.text = currentViewModel.currentStepDesc;
    self.notesLabel.text = currentViewModel.reagentLocation;
    NSString *imageName = [NSString stringWithFormat:@"step%d",currentViewModel.currentStep];
    self.stepIcon.image = [UIImage imageNamed:imageName];
}
@end
