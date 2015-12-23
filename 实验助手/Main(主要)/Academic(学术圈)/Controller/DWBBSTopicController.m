//
//  DWBBSTopicController.m
//  实验助手
//
//  Created by sxq on 15/12/7.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "DWBBSTopic.h"
#import "DWBBSTopicController.h"

@interface DWBBSTopicController ()
@property (nonatomic,strong) DWBBSTopic *bbsTopic;
@property (nonatomic,strong) id<DWBBSTool> bbsTool;
@property (nonatomic,weak) IBOutlet UITextView *topicDetailView;
@end

@implementation DWBBSTopicController
- (instancetype)initWithBBSTopic:(DWBBSTopic *)bbsTopic bbsTool:(id<DWBBSTool>)bbsTool
{
    if (self = [super init]) {
        _bbsTool = bbsTool;
        _bbsTopic = bbsTopic;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self p_setupSelf];
}
- (void)p_setupSelf
{
    self.title = _bbsTopic.topicName;
    self.topicDetailView.text = _bbsTopic.topicDetail;
}
@end
