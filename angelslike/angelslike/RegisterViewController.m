//
//  RegisterViewController.m
//  angelslike
//
//  Created by angelslike on 15/8/10.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import "RegisterViewController.h"

#define ButtonMargin 10
#define ButtonGap 20

@implementation RegisterViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    self.infos = @[@{@"Name":@"请输入帐号",@"IMG":@"iconfont-user",@"Type":@"Normal"},
                   @{@"Name":@"请输入密码",@"IMG":@"iconfont-suo",@"Type":@"Password"},
                   @{@"Name":@"确认密码",@"IMG":@"iconfont-suo",@"Type":@"Password"},
                   @{@"Name":@"手机号码",@"IMG":@"iconfont-shouji",@"Type":@"Normal"},
                   @{@"Name":@"昵称",@"IMG":@"iconfont-user",@"Type":@"Normal"}
                   ];
    [self initialSetting];
}




-(void)initialSetting{
    
    self.navigationItem.title = @"用户注册";
    
//    UINavigationBar *navBar = [[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
//    UINavigationItem *navItem = [[UINavigationItem alloc]initWithTitle:@"用户登陆"];
//    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backButtonClick:)];
//    
//    navItem.leftBarButtonItem = backItem;
//
//    navBar.items = @[navItem];
//    [self.view addSubview:navBar];
    
    for (int i = 0 ; i < [self.infos count] ; i ++){
        NSDictionary *info = [self.infos objectAtIndex:i];
        UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(ButtonMargin, 64 + ButtonGap + 45 * i, ScreenWidth - ButtonMargin * 2, 45)];
        textField.tag = i + 1;
        textField.placeholder = [info strForKey:@"Name"];
        textField.secureTextEntry = [[info strForKey:@"Type"] isEqualToString:@"Password"];
        [self setTextFieldAttribute:textField img:[info strForKey:@"IMG"] bottom:(i == [self.infos count] -1)];
        [self.view addSubview:textField];
        
    }
    


    
    
    RCRoundButton *registButton = [RCRoundButton buttonWithType:UIButtonTypeCustom];
    registButton.frame = CGRectMake(ButtonMargin, 64 + 45 * [self.infos count] + ButtonGap * 2, ScreenWidth - ButtonMargin * 2, 40);
    [registButton setTitle:@"注册" forState:UIControlStateNormal];
    registButton.backgroundColor = [UIColor getHexColor:@"F85C85"];
    [registButton addTarget:self action:@selector(registButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registButton];
}

-(void)registButtonClick:(id)sender{
    for (int i = 0 ; i < [self.infos count] ; i ++){
        UITextField *textField = (UITextField *)[self.view viewWithTag:i + 1];
        NSLog(@"%@",textField.text);
    }
}


-(void)backButtonClick:(id)sender{
    [self dismissViewControllerAnimated:YES completion:^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"bringCustomTabBarToFront" object:nil];
    }];
}

@end
