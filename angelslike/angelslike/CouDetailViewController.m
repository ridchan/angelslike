//
//  CouDetailViewController.m
//  angelslike
//
//  Created by angelslike on 15/8/12.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import "CouDetailViewController.h"

@implementation CouDetailViewController

-(void)viewDidLoad{
    
    [super viewDidLoad];
//    [self.navigationController setHidesBarsOnSwipe:YES];
    

    [self hideTabBar];
    
    [self initialSetting];
    [self addBottomButton];

}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
//    [self initialSetting];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self showTabbar];
}

-(void)addBottomButton{
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight - 44, ScreenWidth, 44)];
    if ([self.info intForKey:@"type"] == 2) {
        RCRoundButton *b1 =  [RCRoundButton buttonWithType:UIButtonTypeCustom];
        b1.frame = CGRectMake(10, 5, ScreenWidth - 20, 34);
        [b1 setBackgroundColor:[UIColor getHexColor:@"F85C85"]];
        [b1 setTitle:@"我也要凑" forState:UIControlStateNormal];
        [v addSubview:b1];
    }else if ([self.info intForKey:@"type"] == 1){
        RCRoundButton *b1 =  [RCRoundButton buttonWithType:UIButtonTypeCustom];
        b1.frame = CGRectMake(10, 5, ScreenWidth / 2 - 15, 34);
        [b1 setBackgroundColor:[UIColor getHexColor:@"FAC116"]];
        [b1 setTitle:@"我要发起" forState:UIControlStateNormal];
        [v addSubview:b1];
        
        RCRoundButton *b2 =  [RCRoundButton buttonWithType:UIButtonTypeCustom];
        b2.frame = CGRectMake(ScreenWidth / 2 + 5, 5, ScreenWidth / 2 - 15, 34);
        [b2 setBackgroundColor:[UIColor getHexColor:@"F85C85"]];
        [b2 setTitle:@"我也要凑" forState:UIControlStateNormal];
        [v addSubview:b2];
    }
    
    [self.view addSubview:v];
}

-(void)initialSetting{
    CouDetail *v = [[CouDetail alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 44)];
    v.hidden = YES;
    v.tag = 99;
    [self.view addSubview:v];
    
    [self refreshClick:nil];

}

-(void)refreshClick:(id)sender{
    __block CouDetail *tempView = (CouDetail *)[self.view viewWithTag:99];
    __block CouDetailViewController *tempSelf = self;
    
    NSDictionary *dic = @{@"id":[self.info strForKey:@"id"],@"type":[self.info strForKey:@"type"],@"json":@"1"};
    [[NetWork shared] query:CouDetailUrl info:dic block:^(id Obj) {
        [tempSelf showNetworkError:[Obj intForKey:@"status"] == 0];
        if ([Obj intForKey:@"status"] == 1) {
            NSDictionary *dic = [[Obj objectForKey:@"data"] objectForKey:@"items"];
            tempView.info = dic;
            tempView.hidden = NO;
        }
    } lock:YES];
    
}




@end
