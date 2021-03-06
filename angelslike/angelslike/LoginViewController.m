//
//  LoginViewController.m
//  angelslike
//
//  Created by angelslike on 15/8/10.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import "LoginViewController.h"

#define ButtonMargin 10
#define ButtonGap 20

@implementation LoginViewController

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)viewDidLoad{
    [super viewDidLoad];

    [self initialSetting];
}


-(void)initialSetting{
    
    
    
    self.navigationItem.title = @"用户登陆";
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 22, 22);
    [button setImage:[UIImage imageNamed:@"iconfont-houtui"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(backButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backButtonClick:)];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"注册  " style:UIBarButtonItemStylePlain target:self action:@selector(registButtonClick:)];
    [rightItem setTintColor:[UIColor whiteColor]];
    self.navigationItem.leftBarButtonItem = backItem;
    self.navigationItem.rightBarButtonItem = rightItem;
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth / 2 - 40, 64 + ButtonGap, 80, 80)];

    imageView.image = [UIImage imageNamed:@"logo_160"];
    [self.view addSubview:imageView];
    
    self.nameField = [[UITextField alloc]initWithFrame:CGRectMake(ButtonMargin, imageView.frame.origin.y + imageView.frame.size.height + ButtonGap, ScreenWidth - ButtonMargin * 2, 45)];
    self.nameField.placeholder = @"请输入帐号";
    [self setTextFieldAttribute:self.nameField img:@"iconfont-user" bottom:0];
    [self.view addSubview:self.nameField];
    
    
    self.psdField = [[UITextField alloc]initWithFrame:CGRectMake(ButtonMargin, self.nameField.frame.origin.y + self.nameField.frame.size.height, ScreenWidth - ButtonMargin * 2, 45)];
    self.psdField.placeholder = @"请输入密码";
    self.psdField.secureTextEntry = YES;
    [self setTextFieldAttribute:self.psdField img:@"iconfont-suo" bottom:2];
    [self.view addSubview:self.psdField];
    
    
    RCRoundButton *loginButton = [RCRoundButton buttonWithType:UIButtonTypeCustom];
    loginButton.frame = CGRectMake(ButtonMargin, self.psdField.frame.origin.y + self.psdField.frame.size.height + ButtonGap, ScreenWidth - ButtonMargin * 2, 40);
    [loginButton setTitle:@"登陆" forState:UIControlStateNormal];
    loginButton.backgroundColor = [UIColor getHexColor:@"F85C85"];
    [loginButton addTarget:self action:@selector(loginButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
    
    UIButton *wxButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [wxButton setImage:[UIImage imageNamed:@"wechat-icon-168"] forState:UIControlStateNormal];
    [wxButton addTarget:self action:@selector(wxloginClick:) forControlEvents:UIControlEventTouchUpInside];
    wxButton.frame = CGRectMake(0, 0, 50, 50);
    wxButton.center = CGPointMake(ScreenWidth / 2, loginButton.frame.origin.y + loginButton.frame.size.height + ButtonGap + 25);
    [self.view addSubview:wxButton];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(wxLoginSuccess:) name:@"LoginSuccess" object:nil];
}

-(void)wxLoginSuccess:(id)sender{
    __block LoginViewController *tempSelf = self;
    [self dismissViewControllerAnimated:YES completion:^{
        [tempSelf showTabbar];
        [tempSelf.bvc setSelectedIndex:4];
    }];

}

-(void)wxloginClick:(id)sender{
    SendAuthReq *req = [[SendAuthReq alloc]init];
    req.scope = @"snsapi_userinfo";
    req.state = @"angelslike";
    [WXApi sendReq:req];
}


-(void)loginButtonClick:(id)sender{
    __block LoginViewController *tempSelf = self;
    [[NetWork shared]startQuery:LoginUrl info:@{@"user":self.nameField.text,@"password":self.psdField.text} completeBlock:^(id Obj) {
        if ([Obj intForKey:@"status"] == 1) {
            [UserInfo shared].info = [Obj objectForKey:@"data"];
            [tempSelf dismissViewControllerAnimated:YES completion:^{
                [tempSelf showTabbar];
                [tempSelf.bvc setSelectedIndex:4];
            }];
        }else{
            [tempSelf showMessage:[Obj strForKey:@"info"]];
        }
        
    }];
}




-(void)backButtonClick:(id)sender{
    __block LoginViewController *tempSelf = self;
    [self dismissViewControllerAnimated:YES completion:^{
        [tempSelf showTabbar];
    }];
}

-(void)registButtonClick:(id)sender{
    RegisterViewController *vc = [[RegisterViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
