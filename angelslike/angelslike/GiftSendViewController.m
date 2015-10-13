//
//  GiftSendViewController.m
//  angelslike
//
//  Created by angelslike on 15/10/12.
//  Copyright © 2015年 angelslike. All rights reserved.
//

#import "GiftSendViewController.h"

@interface GiftSendViewController ()

@end

@implementation GiftSendViewController

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)wxShareResult:(NSNotification *)notification{
    NSDictionary *dic = notification.object;
    if ([dic intForKey:@"status"] == 0) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(wxShareResult:) name:@"WXShareNotification" object:nil];
    
    _scrollView = [[UIScrollView alloc]initWithFrame:RECT(0, 0, ScreenWidth, ScreenHeight)];
    [self.view addSubview:_scrollView];
    
    self.navigationItem.title = @"让TA填写收货地址";
    [self setBackButtonAction:@selector(backClick:)];
    [self createView];
    // Do any additional setup after loading the view.
}

-(void)backClick:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createView {
 
    
    UIView *v1 = [self LableView:RECT(0, 0, ScreenWidth, 40)];
    [_scrollView addSubview:v1];
    UIView *v2 = [self customerTextView:RECT(0, MaxY(v1) + 10, ScreenWidth, 120)];
    [_scrollView addSubview:v2];
    UIView *v3 = [self animationView:RECT(0, MaxY(v2) + 10, ScreenWidth, 250)];
    [_scrollView addSubview:v3];
    _scrollView.contentSize = CGSizeMake(1, MaxY(v3));
}

-(UIView *)LableView:(CGRect)rect{
    UIView *view = [[UIView alloc]initWithFrame:rect];
    view.backgroundColor = RGBA(241, 240, 246, 1);
    
    UILabel *desc = [[UILabel alloc]initWithFrame:RECT(10, 0, ScreenWidth - 20, 40)];
    desc.backgroundColor = [UIColor clearColor];
    desc.font = FontWS(14);
    desc.numberOfLines = 2;
    desc.text = @"把此页发送给收礼人，让Ta填写收货信息，Ta就可以收到礼物啦！";
    [view addSubview:desc];
    return view;
}

-(UIView *)customerTextView:(CGRect)rect{
    UIView *view = [[UIView alloc]initWithFrame:rect];
    view.backgroundColor = [UIColor whiteColor];
    textView = [[UITextView alloc]initWithFrame:RECT(10, 5, rect.size.width - 20, rect.size.height - 10)];
    textView.backgroundColor = RGBA(247, 247, 247, 1);
    textView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    textView.layer.borderWidth = 1.0;
    textView.layer.cornerRadius = 5;
    textView.layer.masksToBounds = YES;
    [view addSubview:textView];
    
    
    RCRoundButton *button = [RCRoundButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"发送给收礼人" forState:UIControlStateNormal];
    [button setBackgroundColor:RGBA(255, 102, 0, 1)];
    [button setCorner:5];
    button.frame = RECT(10, MaxY(textView) + 10, ScreenWidth - 20, 40);
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    view.frame = ResizeHeight(view, MaxY(button) + 10);
    return view;
}

-(void)buttonClick:(id)sender{
    __block GiftSendViewController *tempSelf = self;
    [[NetWork shared] query:SetGiftUrl info:@{@"orderid":[self.info strForKey:@"oid"],@"message":textView.text,@"is_buyone":@"1"} block:^(id Obj) {
        if ([Obj intForKey:@"status"] == 1) {
            [tempSelf shareContent:[tempSelf.info strForKey:@"pname"]
                             title:nil
                         imagePath:[tempSelf.info strForKey:@"pimg"]
                               url:[GiftUrl stringByAppendingString:[[Obj objForKey:@"data"] strForKey:@"key"]]];
        }
    } lock:YES];

}

-(UIView *)animationView:(CGRect)rect{
    UIView *view = [[UIView alloc] initWithFrame:rect];
    view.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:RECT(0, 0, rect.size.width, 35)];
    label.backgroundColor = RGBA(241, 241, 247, 1.0);
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"收礼人收到的礼物是这样的,很贴心吧?";
    [view addSubview:label];
    
    UIView *scaleView = [[UIView alloc]initWithFrame:RECT((ScreenWidth - 250) / 2, 60, 250, 250)];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:RECT(0, 0, 250, 250)];
    UIImageView *coverView = [[UIImageView alloc]initWithFrame:imageView.frame];
    coverView.image =  IMAGE(@"giftCover");
    UIImageView *borderView = [[UIImageView alloc]initWithFrame:imageView.frame];
    borderView.image =  IMAGE(@"product-box");
    
    [scaleView addSubview:imageView];
    [scaleView addSubview:borderView];
    [scaleView addSubview:coverView];
    
    [view addSubview:scaleView];
    
    tempCover = coverView;
    
    [imageView setPreImageWithUrl:[self.info strForKey:@"imgs"] block:^(id Obj) {
        
    }];
    view.frame = ResizeHeight(view, MaxY(scaleView) + 10);
    return view;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
