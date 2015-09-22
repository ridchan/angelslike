//
//  ProductDetailViewController.m
//  angelslike
//
//  Created by angelslike on 15/8/25.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import "ProductDetailViewController.h"

@implementation ProductDetailViewController


-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)viewDidLoad{
    [super viewDidLoad];
    
 
    
    [self initailSetting];
    [self addHeader];
    [self addBottomButton];
    [self loadData:nil];
}



-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
    [super viewWillAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBarHidden = NO;
    [super viewWillDisappear:animated];
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}

-(UIView *)headerView{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 44)];
    view.backgroundColor = [UIColor redColor];
    return view;
}

#pragma mark -


#pragma mark -
#pragma mark init

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{

//    CGRect rect = [[change objectForKey:@"new"] CGRectValue];
    
    
    bottomView.frame = RECT(0, CGRectGetMaxY(pd.frame) + 10, ScreenWidth, 80);
    
    mv.frame = CGRectMake(0, CGRectGetMaxY(bottomView.frame) + 10, ScreenWidth, ScreenHeight - 64);
    
    
    
    scView.contentSize = CGSizeMake(1, mv.frame.origin.y + mv.frame.size.height);
    
    [self.tableView reloadData];
    
}

-(void)initailSetting{
    
//    self.navigationController.navigationBar.alpha = 0.0;
//    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 25, 25);
    [button setImage:[[UIImage imageNamed:@"iconfont-houtui"] rt_tintedImageWithColor:[UIColor blackColor]] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(backClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = barItem;
    
    scView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    scView.showsVerticalScrollIndicator = NO;
    scView.delegate = self;
    [self.view addSubview:scView];
    
    pd = [[ProductDetail alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenWidth * 507 / 640)];
    [pd addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:nil];
    [scView addSubview:pd];
    
    
    
    
    bottomView = [[UIView alloc] initWithFrame:RECT(0, 0, ScreenWidth, 80)];
    bottomView.backgroundColor = [UIColor whiteColor];
    
    UIButton *button1 = [self buttonWithFrame:RECT(10, 0, ScreenWidth - 20, 40) title:@"购买记录"];
    [button1 addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    button1.tag = ButtonType_BuyRecords;
    [bottomView addSubview:button1];
    
    [bottomView addline:CGPointMake(0, 40) color:nil];
    UIButton *button2 = [self buttonWithFrame:RECT(10, 40, ScreenWidth - 20, 40) title:@"凑分子记录"];
    [button2 addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [button2 setTitle:@"凑分子记录" forState:UIControlStateNormal];
    button2.tag = ButtonType_CouRecords;
    [bottomView addSubview:button2];
    
    [scView addSubview:bottomView];
    
    mv = [[RCMutileView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(pd.frame), ScreenWidth, ScreenHeight )];
    [scView addSubview:mv];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(scrollViewCanMove:) name:@"MainScroll" object:nil];
}

-(void)buttonClick:(UIButton *)button{
    ProductRecordViewController *vc = [[ProductRecordViewController alloc]init];
    vc.strid = [self.result strForKey:@"id"];
    if (button.tag == ButtonType_BuyRecords) {
        vc.navigationItem.title = @"购买记录";
        vc.strurl = ProductBuyRecordUrl;
    }else{
        vc.navigationItem.title = @"凑分子记录";
        vc.strurl = ProductCouRecordUrl;
    }
    [self.navigationController pushViewController:vc animated:YES];
}

-(UIButton *)buttonWithFrame:(CGRect)rect title:(NSString *)title{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = rect;
    UILabel *label1 = [[UILabel alloc]initWithFrame:RECT(10, 0, rect.size.width, rect.size.height)];
    label1.backgroundColor = [UIColor clearColor];
    label1.text = title;
    [button addSubview:label1];
    
    UIImageView *imageView =[ [UIImageView alloc]initWithFrame:RECT(rect.size.width - 25, 0, 15, rect.size.height)];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.image = [[UIImage imageNamed:@"iconfont-houtui"] rt_tintedImageWithColor:[UIColor blackColor]];
    imageView.transform = CGAffineTransformMakeRotation(M_PI);
    [button addSubview:imageView];
    
    return button;
    

}




-(void)addHeader{
    header = [[ProductHeader alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 44)];
    [header addTarget:self action:@selector(headerButtonClick:)];
    [self.view addSubview:header];
}

-(void)addBottomButton{
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight - 54, ScreenWidth, 54)];
    v.backgroundColor = [UIColor whiteColor];
    [v.layer addSublayer:[self lineLayer:CGPointMake(0, 0)]];

    
    RCRoundButton *b1 =  [RCRoundButton buttonWithType:UIButtonTypeCustom];
    b1.titleLabel.font = FontWS(16);
    b1.frame = CGRectMake(10, 10, ScreenWidth / 2 - 15, 34);
    [b1 setBackgroundColor:[UIColor getHexColor:@"FAC116"]];
    [b1 setTitleShadowColor:[UIColor getHexColor:@"E4AD05"] forState:UIControlStateNormal];
    [b1 setTitle:@"凑分子购买" forState:UIControlStateNormal];
    [b1 addTarget:self action:@selector(counow:) forControlEvents:UIControlEventTouchUpInside];
    [v addSubview:b1];
    
    RCRoundButton *b2 =  [RCRoundButton buttonWithType:UIButtonTypeCustom];
    b2.titleLabel.font = FontWS(16);
    b2.frame = CGRectMake(ScreenWidth / 2 + 5, 10, ScreenWidth / 2 - 15, 34);
    [b2 setBackgroundColor:[UIColor getHexColor:@"F85C85"]];
    [b2 setTitleShadowColor:[UIColor getHexColor:@"F7356A"] forState:UIControlStateNormal];
    [b2 setTitle:@"立即购买" forState:UIControlStateNormal];
    [b2 addTarget:self action:@selector(buynow:) forControlEvents:UIControlEventTouchUpInside];
    [v addSubview:b2];
    
    
    [self.view addSubview:v];
}



#pragma mark -
#pragma mark action

-(void)headerButtonClick:(UIButton *)sender{
    if (sender.tag == 1) {
        self.navigationController.navigationBarHidden = NO;
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)counow:(id)sender {
    StartCouViewViewController *vc = [[StartCouViewViewController alloc]init ];
    vc.P = [NSMutableDictionary dictionaryWithDictionary:self.result];
    [self.navigationController pushViewController:vc animated:YES];

}


-(void)buynow:(id)sender{
    BuyNowViewController *vc = [[BuyNowViewController alloc]init];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:self.result];
    [dic setObject:@"1" forKey:@"qty"];
    vc.products = [NSMutableArray arrayWithObject:dic];
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

    mv.viewControllers = @[vc1,vc2];
}

-(void)scrollViewCanMove:(NSNotification *)obj{
    canMove = NO;
    scView.scrollEnabled = YES;
    [scView becomeFirstResponder];
}




-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    header.alpha = scrollView.contentOffset.y / 200;
    

    if (scrollView.contentOffset.y + 44  > mv.frame.origin.y) {
        scrollView.contentOffset  = CGPointMake(0, mv.frame.origin.y - 44);
        if(scrollView.scrollEnabled){
            scrollView.scrollEnabled = NO;
            [scrollView resignFirstResponder];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"SubScrollCanMove" object:nil];
        }
   
    }else if (scrollView.contentOffset.y < 0){
        scrollView.contentOffset = CGPointMake(0, 0);
    }
    
    
}





-(void)loadData:(id)sender{
    __block ProductDetailViewController *tempSelf = self;
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[self.info strForKey:@"id"],@"id",nil];
    [[NetWork shared] query:ProductUrl info:dic block:^(id Obj) {
        if ([Obj intForKey:@"status"] == 1) {
            tempSelf.result = [Obj objectForKey:@"data"];
            [tempSelf setSubView];
        }else{
            [tempSelf showMessage:[Obj strForKey:@"info"]];
        }

    } lock:YES];
}

-(void)backClick:(id)sender{
    self.navigationController.navigationBar.barTintColor = [UIColor getHexColor:@"ff6969"];
    self.navigationController.navigationBar.alpha = 1.0;
    [pd removeObserver:self forKeyPath:@"frame"];
    [self.navigationController popViewControllerAnimated:YES];
}




@end
