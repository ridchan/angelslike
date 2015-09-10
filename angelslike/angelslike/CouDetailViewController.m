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
    [self addViewController];

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

-(void)addViewController{
    
    CouDetail *v = (CouDetail *)[self.view viewWithTag:99];
//    v.delegate = self;
    mv = [[RCMutileView alloc]initWithFrame:CGRectMake(0, v.frame.size.height, ScreenWidth, ScreenHeight - 64)];
    mv.titles = @[@"谁在凑",@"凑热闹"];
    
    CouRecordsViewController *vc1 = [[CouRecordsViewController alloc]init];
    vc1.info = @{@"id":[self.info strForKey:@"id"],@"type":@"2"};
    
    CommentViewController *vc2 = [[CommentViewController alloc]init];
    vc2.info = @{@"id":[self.info strForKey:@"id"],@"type":@"2"};
    mv.viewControllers = @[vc1,vc2];
    
    
    [v addToView:mv];
    
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
}



-(void)addBottomButton{
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight - 54, ScreenWidth, 54)];
    v.backgroundColor = [UIColor whiteColor];
    [v.layer addSublayer:[self lineLayer:CGPointMake(0, 0)]];
    if ([self.info intForKey:@"type"] == 2) {
        RCRoundButton *b1 =  [RCRoundButton buttonWithType:UIButtonTypeCustom];
        b1.frame = CGRectMake(10, 10, ScreenWidth - 20, 34);
        [b1 setBackgroundColor:[UIColor getHexColor:@"F85C85"]];
        b1.titleLabel.font = FontWS(16);
        [b1 setTitle:@"我也要凑" forState:UIControlStateNormal];
        [b1 setTitleShadowColor:[UIColor getHexColor:@"F7356A"] forState:UIControlStateNormal];
        [v addSubview:b1];
    }else if ([self.info intForKey:@"type"] == 1){
        RCRoundButton *b1 =  [RCRoundButton buttonWithType:UIButtonTypeCustom];
        b1.frame = CGRectMake(10, 10, ScreenWidth / 2 - 15, 34);
        [b1 setBackgroundColor:[UIColor getHexColor:@"FAC116"]];
        [b1 setTitleShadowColor:[UIColor getHexColor:@"E4AD05"] forState:UIControlStateNormal];
        [b1 addTarget:self action:@selector(productClick:) forControlEvents:UIControlEventTouchUpInside];
        [b1 setTitle:@"我要发起" forState:UIControlStateNormal];
        b1.titleLabel.font = FontWS(16);
        [v addSubview:b1];
        
        RCRoundButton *b2 =  [RCRoundButton buttonWithType:UIButtonTypeCustom];
        b2.frame = CGRectMake(ScreenWidth / 2 + 5, 10, ScreenWidth / 2 - 15, 34);
        b2.titleLabel.font = FontWS(16);
        [b2 setBackgroundColor:[UIColor getHexColor:@"F85C85"]];
        [b2 setTitle:@"我也要凑" forState:UIControlStateNormal];
        [b2 setTitleShadowColor:[UIColor getHexColor:@"F7356A"] forState:UIControlStateNormal];
        [b2 addTarget:self action:@selector(couPayClick:) forControlEvents:UIControlEventTouchUpInside];
        [v addSubview:b2];
    }
    
    [self.view addSubview:v];
}

-(void)initialSetting{
    CouDetail *v = [[CouDetail alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight )];
    v.hidden = YES;
    v.tag = 99;
    [self.view addSubview:v];
    
    
    cp = [[CouPay alloc]init];
    [self.view addSubview:cp];
    
    
    [self setBackButtonAction:@selector(backClick:)];
    

    self.navigationItem.title = @"凑分子";
    [self refreshClick:nil];

}

-(void)productClick:(id)obj{
    CouDetail *cd  = (CouDetail *)[self.view viewWithTag:99];
    ProductDetailViewController *vc = [[ProductDetailViewController alloc] init];
    vc.info = [NSDictionary dictionaryWithObject:[cd.info strForKey:@"pid"] forKey:@"id"];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)couPayClick:(id)sender{
    cp.info = [NSMutableDictionary dictionaryWithObject:[self.info strForKey:@"everyprice"] forKey:@"price"];
    [cp show];
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
