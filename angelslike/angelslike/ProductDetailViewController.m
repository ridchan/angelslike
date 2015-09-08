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


#pragma mark -
#pragma mark init

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{

    CGRect rect = [[change objectForKey:@"new"] CGRectValue];
    
    mv.frame = CGRectMake(0, rect.size.height + rect.origin.y + 10, ScreenWidth, ScreenHeight - 64);
    scView.contentSize = CGSizeMake(1, mv.frame.origin.y + mv.frame.size.height);
    
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
    
    mv = [[RCMutileView alloc]initWithFrame:CGRectMake(0, pd.frame.size.height + pd.frame.origin.y, ScreenWidth, ScreenHeight )];
    [scView addSubview:mv];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(scrollViewCanMove:) name:@"MainScroll" object:nil];
}

-(void)scrollViewCanMove:(NSNotification *)obj{
    NSNumber *num = obj.object;
    scView.scrollEnabled = YES;
    scView.contentOffset = CGPointMake(0, scView.contentOffset.y + [num floatValue]);
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
//    StartCouViewViewController *vc = [[StartCouViewViewController alloc]init ];
//    vc.P = [NSMutableDictionary dictionaryWithDictionary:self.info];
//    [self.navigationController pushViewController:vc animated:YES];
    
    
    UIImage *_originImage = [UIImage imageNamed:@"download"];
    
    NSData *_data = UIImageJPEGRepresentation(_originImage,1.0);
    
    NSString *_encodedImageStr = [_data base64Encoding];
    
    [[NetWork shared] query:@"http://weixin.angelslike.com/json/saveimage" info:@{@"type":@"cou",@"base64":[self encodeURL:_encodedImageStr]} block:^(id Obj) {
        NSLog(@"obj %@",Obj);
    } lock:YES];

}

- (NSString*)encodeURL:(NSString *)string
{
    NSString *newString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes( kCFAllocatorDefault, (CFStringRef)string, NULL, CFSTR(":/?#[]@!$ &'()*+,;=\"<>%{}|\\^~`"),kCFStringEncodingUTF8));
    if (newString) {
        return newString;
    }
    return @"";
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

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    header.alpha = scrollView.contentOffset.y / 200;

    if (scrollView.contentOffset.y + 44  > mv.frame.origin.y) {
        scrollView.scrollEnabled = NO;
        float off = scrollView.contentOffset.y + 44  - mv.frame.origin.y;
        scrollView.contentOffset  = CGPointMake(0, mv.frame.origin.y - 44);
        [scrollView resignFirstResponder];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"SubScrollCanMove" object:[NSNumber numberWithFloat:off]];
   
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
