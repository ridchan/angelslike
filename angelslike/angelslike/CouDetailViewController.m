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
    

//    [self.navigationController setHidesBarsOnSwipe:YES];
    
    
    [self hideTabBar];
    CouDetail *v = [[CouDetail alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    
    [self.view addSubview:v];

    __block CouDetail *tempView = v;
    NSDictionary *dic = @{@"id":[self.info strForKey:@"id"],@"type":[self.info strForKey:@"type"],@"json":@"1"};
    [[NetWork shared]startQuery:CouDetailUrl info:dic completeBlock:^(id Obj) {
        NSDictionary *dic = [[Obj objectForKey:@"data"] objectForKey:@"items"];
        tempView.info = dic;

    }];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self showTabbar];
}

-(void)initialSetting{
    

 
    
}




@end
