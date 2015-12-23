//
//  DWMeCell.m
//  实验助手
//
//  Created by sxq on 15/11/25.
//  Copyright © 2015年 SXQ. All rights reserved.
//

#import "DWMeCell.h"
#import "DWMeItem.h"
@interface DWMeCell ()
@property (nonatomic,weak) IBOutlet UIImageView *iconView;
@property (nonatomic,weak) IBOutlet UILabel *itemTitle;
@end
@implementation DWMeCell
-(void)setMeItem:(DWMeItem *)meItem
{
    _meItem = meItem;
    if (meItem.icon) {
        self.iconView.image = [UIImage imageNamed:meItem.icon];
    }
    self.itemTitle.text = meItem.title;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
