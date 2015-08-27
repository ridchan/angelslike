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
    
    [self initialSetting];
    [self addBottomButton];
    

}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
//    [self initialSetting];
    
}


-(CAShapeLayer *)lineLayer:(CGPoint)position{
    CAShapeLayer *layer = [CAShapeLayer new];
    UIBezierPath *path = [UIBezierPath new];
    [path moveToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(ScreenWidth, 0)];
    
    
    layer.path = path.CGPath;
    layer.lineWidth = 0.5;
    layer.strokeColor = RGBA(178,177,182,.9).CGColor;
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.position = position;
    return layer;
}

-(void)addBottomButton{
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight - 44, ScreenWidth, 44)];
    [v.layer addSublayer:[self lineLayer:CGPointMake(0, 0)]];
    if ([self.info intForKey:@"type"] != 1) {
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
    
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 25, 25);
    [button setImage:[UIImage imageNamed:@"iconfont-houtui"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(backClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = barItem;
    self.navigationItem.title = @"凑分子";
    [self refreshClick:nil];

}

-(void)backClick:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)refreshClick:(id)sender{
    __block CouDetail *tempView = (CouDetail *)[self.view viewWithTag:99];
    __block CouDetailViewController *tempSelf = self;
    
    NSDictionary *dic = @{@"id":[self.info strForKey:@"id"]};
    [[NetWork shared] query:CouDetailUrl info:dic block:^(id Obj) {
        [tempSelf showNetworkError:[Obj intForKey:@"status"] == 0];
        if ([Obj intForKey:@"status"] == 1) {
            NSDictionary *dic = [Obj objectForKey:@"data"] ;
            tempView.info = dic;
            tempView.hidden = NO;
        }
    } lock:YES];
    
}




@end
