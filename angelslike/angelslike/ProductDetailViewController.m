//
//  ProductDetailViewController.m
//  angelslike
//
//  Created by angelslike on 15/8/25.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import "ProductDetailViewController.h"

@implementation ProductDetailViewController


-(void)viewDidLoad{
    [super viewDidLoad];
    
    [self initailSetting];
    [self addBottomButton];
    [self loadData:nil];
}



#pragma mark -
#pragma mark init

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    NSLog(@"change %@",change);
    CGRect rect = [[change objectForKey:@"new"] CGRectValue];
    
    mv.frame = CGRectMake(0, rect.size.height + rect.origin.y + 10, ScreenWidth, ScreenHeight - 64);
    scView.contentSize = CGSizeMake(1, mv.frame.origin.y + mv.frame.size.height);
    
}

-(void)initailSetting{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 25, 25);
    [button setImage:[UIImage imageNamed:@"iconfont-houtui"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(backClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = barItem;
    
    scView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    scView.delegate = self;
    [self.view addSubview:scView];
    
    pd = [[ProductDetail alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenWidth * 507 / 640)];
    [pd addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:nil];
    [scView addSubview:pd];
    
    mv = [[RCMutileView alloc]initWithFrame:CGRectMake(0, pd.frame.size.height + pd.frame.origin.y, ScreenWidth, ScreenHeight )];
    
    

    [scView addSubview:mv];
}

-(void)addBottomButton{
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight - 44, ScreenWidth, 44)];
    v.backgroundColor = [UIColor whiteColor];
    [v.layer addSublayer:[self lineLayer:CGPointMake(0, 0)]];

    
    RCRoundButton *b1 =  [RCRoundButton buttonWithType:UIButtonTypeCustom];
    b1.frame = CGRectMake(10, 5, ScreenWidth / 2 - 15, 34);
    [b1 setBackgroundColor:[UIColor getHexColor:@"FAC116"]];
    [b1 setTitle:@"凑分子购买" forState:UIControlStateNormal];
    [v addSubview:b1];
    
    RCRoundButton *b2 =  [RCRoundButton buttonWithType:UIButtonTypeCustom];
    b2.frame = CGRectMake(ScreenWidth / 2 + 5, 5, ScreenWidth / 2 - 15, 34);
    [b2 setBackgroundColor:[UIColor getHexColor:@"F85C85"]];
    [b2 setTitle:@"立即购买" forState:UIControlStateNormal];
    [b2 addTarget:self action:@selector(buynow:) forControlEvents:UIControlEventTouchUpInside];
    [v addSubview:b2];
    
    
    [self.view addSubview:v];
}

#pragma mark -
#pragma mark action

-(void)buynow:(id)sender{
    BuyNowViewController *vc = [[BuyNowViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)setSubView{
    
    [pd setInfo:self.result];
    
    WebViewController *vc1 = [[WebViewController alloc]init];
    mv.titles = @[@"图文介绍",@"评论"];
    vc1.content = [self.result strForKey:@"desc"];
    
    CommentViewController *vc2 = [[CommentViewController alloc]init];
    vc2.info = [NSDictionary dictionaryWithObjectsAndKeys:
                [self.result strForKey:@"id"],@"id",
                @"1",@"type",
                nil];
//    vc1.baseUrl = @"http://img1.angelslike.com";
    mv.viewControllers = @[vc1,vc2];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.y + 64  > mv.frame.origin.y) {
        scrollView.contentOffset  = CGPointMake(0, mv.frame.origin.y - 64);
    }
}

-(void)loadData:(id)sender{
    __block ProductDetailViewController *tempSelf = self;
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[self.info strForKey:@"id"],@"id",nil];
    [[NetWork shared] query:ProductUrl info:dic block:^(id Obj) {
        tempSelf.result = [Obj objectForKey:@"data"];
        [tempSelf setSubView];
    } lock:YES];
}

-(void)backClick:(id)sender{
    [pd removeObserver:self forKeyPath:@"frame"];
    [self.navigationController popViewControllerAnimated:YES];
}



@end
