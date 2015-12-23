//
//  DWInstructionDetailHeader.m
//  实验助手
//
//  Created by sxq on 15/11/16.
//  Copyright © 2015年 SXQ. All rights reserved.
//

#import "DWInstructionDetailHeader.h"
@interface DWInstructionDetailHeader ()
@property (weak, nonatomic) IBOutlet UIImageView *backgroundView;

@end
@implementation DWInstructionDetailHeader
- (void)awakeFromNib
{
    self.backgroundColor = [UIColor whiteColor];
    self.headerBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
//    self.backgroundView.image = [[UIImage imageNamed:@"common_card_top_background_os7"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
}
@end
