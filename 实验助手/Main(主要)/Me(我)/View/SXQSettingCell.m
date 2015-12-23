//
//  SXQSettingCell.m
//  实验助手
//
//  Created by sxq on 15/11/4.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "SXQSettingItem.h"
#import "SXQSettingCell.h"
@interface SXQSettingCell ()
@property (nonatomic,weak) IBOutlet UILabel *settingTitle;
@property (nonatomic,weak) IBOutlet UIImageView *seperatorLine;
@end
@implementation SXQSettingCell

- (void)awakeFromNib {
    // Initialization code
//    self.backgroundView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"settings_statistic_background"] resizableImageWithCapInsets:UIEdgeInsetsMake(1, 1, 1, 1) resizingMode:UIImageResizingModeStretch]];
//    self.selectedBackgroundView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"settings_statistic_background"] resizableImageWithCapInsets:UIEdgeInsetsMake(1, 1, 1, 1) resizingMode:UIImageResizingModeStretch]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setItem:(SXQSettingItem *)item
{
    _item = item;
    self.settingTitle.text = item.title;
}
- (void)configureCellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath item:(SXQSettingItem *)item
{
    NSUInteger totalRows = [tableView numberOfRowsInSection:indexPath.section];
    NSString *bgImageName = nil;
    NSString *selectedBgImageName = nil;
    if (totalRows - 1 == indexPath.row ) {//最后一行
        bgImageName = @"common_card_middle_background";
        selectedBgImageName = @"settings_statistic_form_background_below";
    }else if(indexPath.row == 0)//第一行
    {
        bgImageName = @"common_card_middle_background";
        selectedBgImageName = @"settings_statistic_form_background_above";
    }else //中间行
    {
        bgImageName = @"common_card_middle_background";
        selectedBgImageName = @"settings_statistic_form_background_middle";
    }
    self.backgroundView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:bgImageName] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10) resizingMode:UIImageResizingModeStretch]];
    self.selectedBackgroundView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:selectedBgImageName] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10) resizingMode:UIImageResizingModeStretch]];
    self.item = item;
}
@end
