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

-(void)viewDidLoad{
    [super viewDidLoad];

//    [[NSNotificationCenter defaultCenter] postNotificationName:@"hideCustomTabBar" object:nil];
    [self initialSetting];
}


-(void)initialSetting{
    
    
    
    self.navigationItem.title = @"用户登陆";
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backButtonClick:)];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"注册" style:UIBarButtonItemStylePlain target:self action:@selector(registButtonClick:)];
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
}


-(void)loginButtonClick:(id)sender{
    __block LoginViewController *tempSelf = self;
    [[NetWork shared]startQuery:LoginUrl info:@{@"user":self.nameField.text,@"password":self.psdField.text} completeBlock:^(id Obj) {
        if ([Obj intForKey:@"status"] == 1) {
            [UserInfo shared].info = [Obj objectForKey:@"data"];
            [tempSelf dismissViewControllerAnimated:YES completion:^{
                [tempSelf.bvc setSelectedIndex:4];
            }];
        }else{
            [tempSelf showMessage:[Obj strForKey:@"info"]];
        }
        
    }];
}




-(void)backButtonClick:(id)sender{
    [self dismissViewControllerAnimated:YES completion:^{

    }];
}

-(void)registButtonClick:(id)sender{
    RegisterViewController *vc = [[RegisterViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
