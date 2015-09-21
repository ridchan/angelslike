//
//  StartViewController.m
//  angelslike
//
//  Created by angelslike on 15/9/21.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import "StartViewController.h"

@interface StartViewController ()

@end

@implementation StartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"发起凑分子";
    [self setBackButtonAction:@selector(backButtonClick:)];
    
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:RECT(0, 0, ScreenWidth, ScreenHeight)];
    
    [self.view addSubview:scrollView];
    
    [scrollView addSubview:[self headerView]];
    UIView *bottomView = [self bottomView];
    [scrollView addSubview:bottomView];
    scrollView.contentSize = CGSizeMake(1, CGRectGetMaxY(bottomView.frame));
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)backButtonClick:(id)sender{
    self.failblock(nil);
    [self.navigationController dismissViewControllerAnimated:YES completion:NULL];
    
}

//header view
-(void)buttonClick:(id)sender{
    self.successblock(nil);
    [self.navigationController dismissViewControllerAnimated:YES completion:NULL];
}

-(UIView *)headerView{
    UIView *view = [[UIView alloc] initWithFrame:RECT(0, 20, ScreenWidth, 135)];
    view.backgroundColor = [UIColor whiteColor];
    [view addline:CGPointMake(0, 0) color:nil];
    [view addline:CGPointMake(0, 135) color:nil];
    
    [view addSubview:[self labelWithFrame:RECT(10, 0, ScreenWidth, 42) size:18 color:[UIColor blackColor] title:@"发起人" bold:YES]];
    [view addSubview:[self headImage:RECT(10, 42 , 70, 70)]];
    [view addSubview:[self labelWithFrame:RECT(90, 42, ScreenWidth - 100, 20) size:13 color:RGBA(24, 24, 27, .8) title:[[UserInfo shared].info strForKey:@"name"] bold:YES]];
    [view addSubview:[self labelWithFrame:RECT(90, 62, ScreenWidth - 100, 20) size:13 color:RGBA(24, 24, 27, .8) title:[[NSDate date] description] bold:NO]];
    [view addSubview:[self chooseButton:RECT(ScreenWidth - 100, 90, 76, 30)]];
    return view;
}

-(UIButton *)chooseButton:(CGRect)frame{
    RCRoundButton *button =  [RCRoundButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setCorner:8];
    button.backgroundColor = HexColor(@"FF696A");
    [button setTitle:@"选礼物" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}


-(UIImageView *)headImage:(CGRect)rect{
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:rect];
    [imgView setPreImageWithUrl:[[UserInfo shared].info strForKey:@"img"]];
    imgView.layer.masksToBounds = YES;
    imgView.layer.cornerRadius = rect.size.width / 2;
    
    return imgView;
}

-(UILabel *)labelWithFrame:(CGRect)rect size:(CGFloat)fontSize color:(UIColor *)fontColor title:(NSString *)title bold:(BOOL)blod{
    UILabel *label = [[UILabel alloc]initWithFrame:rect];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = fontColor;
    label.font = blod?BFontWS(fontSize):FontWS(fontSize);
    label.text = title;
    label.numberOfLines = 10;
    return label;
}

//bottom view

-(UIView *)bottomView{
    UIView *view = [[UIView alloc] initWithFrame:RECT(0, 175, ScreenWidth, 0)];
    view.backgroundColor = [UIColor whiteColor];
    [view addline:CGPointMake(0, 0) color:nil];
    
    [view addSubview:[self labelWithFrame:CGRectMake(10, 0, ScreenWidth - 20, 42) size:18 color:[UIColor blackColor] title:@"什么叫凑分子" bold:YES]];
    [view addSubview:[self labelWithFrame:CGRectMake(10, 42, ScreenWidth - 20, 50) size:13 color:HexColor(@"575757") title:@"一个人先选一份礼物，将价格分成若干份，用微信发给其他熟人，约请每人凑一份子钱，完成购买，送给另一个人" bold:NO]];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:RECT(10, 120, ScreenWidth - 20, (ScreenWidth - 20) * 33 / 30)];
    imageView.image = [UIImage imageNamed:@"wcoufenzi"];
    [view addSubview:imageView];
    
    view.frame = RECT(0, 175, ScreenWidth, CGRectGetMaxY(imageView.frame));
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
