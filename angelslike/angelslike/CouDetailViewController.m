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



-(BOOL)checkUser{
    return ([[self.info strForKey:@"uid"] isEqualToString:[[UserInfo shared].info strForKey:@"id"]]);
}

-(void)addBottomButton{
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight - 54, ScreenWidth, 54)];
    v.backgroundColor = [UIColor whiteColor];
    [v.layer addSublayer:[self lineLayer:CGPointMake(0, 0)]];

    RCRoundButton *b1 =  [RCRoundButton buttonWithType:UIButtonTypeCustom];
    b1.frame = CGRectMake(10, 10, ScreenWidth / 2 - 15, 34);
    [b1 setBackgroundColor:[UIColor getHexColor:@"FAC116"]];
    [b1 setTitleShadowColor:[UIColor getHexColor:@"E4AD05"] forState:UIControlStateNormal];
    [b1 addTarget:self action:@selector(productClick:) forControlEvents:UIControlEventTouchUpInside];
    if ([self checkUser])
        [b1 setTitle:@"编辑" forState:UIControlStateNormal];
    else
        [b1 setTitle:@"我要发起" forState:UIControlStateNormal];
    b1.titleLabel.font = FontWS(16);
    [v addSubview:b1];
    
    RCRoundButton *b2 =  [RCRoundButton buttonWithType:UIButtonTypeCustom];
    b2.frame = CGRectMake(ScreenWidth / 2 + 5, 10, ScreenWidth / 2 - 15, 34);
    b2.titleLabel.font = FontWS(16);
    [b2 setBackgroundColor:[UIColor getHexColor:@"F85C85"]];
    if ([self checkUser])
        [b2 setTitle:@"补齐余额" forState:UIControlStateNormal];
    else
        [b2 setTitle:@"我也要凑" forState:UIControlStateNormal];
    [b2 setTitleShadowColor:[UIColor getHexColor:@"F7356A"] forState:UIControlStateNormal];
    [b2 addTarget:self action:@selector(couPayClick:) forControlEvents:UIControlEventTouchUpInside];
    [v addSubview:b2];

    
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

-(void)weixinpayResult:(NSNotification *)notification{
    [[NSNotificationCenter defaultCenter]removeObserver:self forKeyPath:@"WeiXinPayResult"];
    NSDictionary *dic = notification.object;
    if ([dic intForKey:@"status"] == 0) {
        [self showMessage:@"支付成功"];
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self showMessage:@"支付失败"];
    }
}

-(void)submitClick:(NSDictionary *)dic{
    [[NetWork shared] query:CouPayUrl info:dic block:^(id Obj) {
        if ([Obj intForKey:@"status"] == 1) {
            NSDictionary *orderInfo = [Obj objectForKey:@"data"];
            if ([dic intForKey:@"paytype"] == 4) {
                [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(weixinpayResult:) name:@"WeiXinPayResult" object:nil];
                NSString *namt = [NSString stringWithFormat:@"%.0f",[[orderInfo strForKey:@"mPrice"] floatValue] * 100];
                [WeiXinPayObj payWithInfo:@{@"orderno":[orderInfo strForKey:@"orderid"],@"amount":namt} successBlock:nil failBlock:nil];
            }else{
                
                [AliPayObj payWithInfo:@{@"orderno":[orderInfo strForKey:@"orderid"],@"amount":[orderInfo strForKey:@"mPrice"]} successBlock:^(id obj) {
                    [cp dismiss];
                } failBlock:^(id obj) {
                    [[NetWork shared] query:CancelOrderUrl info:@{@"orderno":[orderInfo strForKey:@"orderid"]} block:nil lock:NO];
                }];
            }
        }
    } lock:YES];
}

-(void)productClick:(id)obj{
    CouDetail *cd  = (CouDetail *)[self.view viewWithTag:99];
    ProductDetailViewController *vc = [[ProductDetailViewController alloc] init];
    vc.info = [NSDictionary dictionaryWithObject:[cd.info strForKey:@"pid"] forKey:@"id"];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)couPayClick:(id)sender{
    if ([self checkUser]) {
        NSInteger cop = [self.info intForKey:@"copies"] - [self.info intForKey:@"currentcopies"];
        cp.info = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                   [self.info strForKey:@"everyprice"],@"price",
                   [self.info strForKey:@"id"],@"id",
                   [[NSNumber numberWithInteger:cop] stringValue],@"maxValue",
                   [[NSNumber numberWithInteger:cop] stringValue],@"minValue",
                   nil];
    }else{
        cp.info = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                   [self.info strForKey:@"everyprice"],@"price",
                   [self.info strForKey:@"id"],@"id",
                   nil];
    }
    [cp addTarget:self action:@selector(submitClick:)];
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
