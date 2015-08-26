//
//  AbountUsViewController.m
//  angelslike
//
//  Created by angelslike on 15/8/26.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import "AbountUsViewController.h"

@implementation AbountUsViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    self.navigationItem.title = @"关于我们";
    [self initialSetting];
}

-(void)initialSetting{
    UITextView *textView = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 80)];
    textView.font = FontWS(17);
    textView.text  = @"      天使礼客是一个以时尚创意生活品和“礼”的周边产品为核心内容、“凑份子”送礼为特色的电商平台，提供创意礼品与订制品，是一个基于关系维度的礼物应用。\n      “凑份子”是产品微众筹的概念，也是天使礼客的一个特色功能。发起人先选一份目标礼物，将价格分成若干份，用微信发给其他人，邀请每人凑一份子钱，完成购买后送给目标人。";
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, ScreenHeight - 80, ScreenWidth, 80)];
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor whiteColor];
    label.text = @"Copyright©2015-2016\n广州市派乐商贸有限公司";
    label.textColor = RGBA(178,177,182,.9);
    label.font = FontWS(12);
    label.numberOfLines = 2;
    [self.view addSubview:textView];
    [self.view addSubview:label];
    
}

@end
