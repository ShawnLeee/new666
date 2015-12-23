//
//  DWLoginViewController.m
//  实验助手
//
//  Created by sxq on 15/11/17.
//  Copyright © 2015年 SXQ. All rights reserved.
//

#import "DWLoginViewController.h"

@interface DWLoginViewController ()
@property (nonatomic,weak) IBOutlet UIImageView *bgView;
@end

@implementation DWLoginViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.bgView.image = [UIImage imageNamed:@"lab_login_bg"];
}
- (IBAction)signUp:(UIButton *)sender
{
    [self p_presentViewControllerWithVCIdentifier:@"SignUpNavigationController"];
}
- (IBAction)login:(id)sender
{
    [self p_presentViewControllerWithVCIdentifier:@"DWLoginVC"];
}
- (void)p_presentViewControllerWithVCIdentifier:(NSString *)vcIdentifier
{
     UIViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:vcIdentifier];
    [self presentViewController:vc animated:YES completion:nil];
}
- (void)awakeFromNib
{
}
@end
