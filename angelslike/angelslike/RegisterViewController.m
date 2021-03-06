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


#define REGEX_USER_NAME_LIMIT @"^.{3,10}$"
#define REGEX_USER_NAME @"[A-Za-z0-9]{3,10}"
#define REGEX_EMAIL @"[A-Z0-9a-z._%+-]{3,}+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
#define REGEX_PASSWORD_LIMIT @"^.{6,20}$"
#define REGEX_PASSWORD @"[A-Za-z0-9]{6,20}"
#define REGEX_PHONE_DEFAULT @"^((13[0-9])|(147)|(15[^4,\\D])|(18[0,5-9]))\\d{8}$"

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


-(void)popViewController:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)initialSetting{
    
    self.navigationItem.title = @"用户注册";
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 22, 22);
    [button setImage:[UIImage imageNamed:@"iconfont-houtui"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(popViewController:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = backItem;

    
    TextFieldValidator *textField = [[TextFieldValidator alloc]initWithFrame:CGRectMake(ButtonMargin, 64 + ButtonGap + 45 * 0, ScreenWidth - ButtonMargin * 2, 45)];
    textField.tag = 1;
    textField.placeholder = @"请输入帐号";
    textField.secureTextEntry = NO;
    [self setTextFieldAttribute:textField img:@"iconfont-user" bottom:0];
    [textField addRegx:REGEX_USER_NAME_LIMIT withMsg:@"帐号为3-10个字符"];
    [textField addRegx:REGEX_USER_NAME withMsg:@"只能输入数字或字符"];
    textField.validateOnResign = NO;
    textField.delegate = self;
    [self.view addSubview:textField];
    
    TextFieldValidator *textField1 = [[TextFieldValidator alloc]initWithFrame:CGRectMake(ButtonMargin, 64 + ButtonGap + 45 * 1, ScreenWidth - ButtonMargin * 2, 45)];
    textField1.tag = 2;
    textField1.placeholder = @"请输入密码";
    textField1.secureTextEntry = YES;
    [self setTextFieldAttribute:textField1 img:@"iconfont-suo" bottom:1];
    [textField1 addRegx:REGEX_PASSWORD_LIMIT withMsg:@"密码为6-20位"];
    [textField1 addRegx:REGEX_PASSWORD withMsg:@"只能输入数字或字符"];
    textField1.delegate = self;
    [self.view addSubview:textField1];
    
    TextFieldValidator *textField2 = [[TextFieldValidator alloc]initWithFrame:CGRectMake(ButtonMargin, 64 + ButtonGap + 45 * 2, ScreenWidth - ButtonMargin * 2, 45)];
    textField2.tag = 3;
    textField2.placeholder = @"确认密码";
    textField2.secureTextEntry = YES;
    [self setTextFieldAttribute:textField2 img:@"iconfont-suo" bottom:1];
    [textField2 addRegx:REGEX_PASSWORD_LIMIT withMsg:@"密码为6-20位"];
    [textField2 addRegx:REGEX_PASSWORD withMsg:@"只能输入数字或字符"];
    [textField2 addConfirmValidationTo:textField1 withMsg:@"密码不一致"];
    textField2.delegate = self;
    [self.view addSubview:textField2];
    
    TextFieldValidator *textField3 = [[TextFieldValidator alloc]initWithFrame:CGRectMake(ButtonMargin, 64 + ButtonGap + 45 * 3, ScreenWidth - ButtonMargin * 2, 45)];
    textField3.tag = 4;
    textField3.placeholder = @"请输入手机号码";
    textField3.secureTextEntry = NO;
    [self setTextFieldAttribute:textField3 img:@"iconfont-shouji" bottom:1];
    [textField3 addRegx:REGEX_PHONE_DEFAULT withMsg:@"请输入正确的手机号码"];
    textField3.delegate = self;
    [self.view addSubview:textField3];
    
    TextFieldValidator *textField4 = [[TextFieldValidator alloc]initWithFrame:CGRectMake(ButtonMargin, 64 + ButtonGap + 45 * 4, ScreenWidth - ButtonMargin * 2, 45)];
    textField4.tag = 5;
    textField4.placeholder = @"昵称";
    textField4.secureTextEntry = NO;
    textField4.isMandatory=NO;
    textField4.delegate = self;
    [self setTextFieldAttribute:textField4 img:@"iconfont-user" bottom:2];
    [self.view addSubview:textField4];
    
    
    
    [textField addTarget:self action:@selector(valueChange:) forControlEvents:UIControlEventEditingChanged];
    [textField1 addTarget:self action:@selector(valueChange:) forControlEvents:UIControlEventEditingChanged];
    [textField2 addTarget:self action:@selector(valueChange:) forControlEvents:UIControlEventEditingChanged];
    [textField3 addTarget:self action:@selector(valueChange:) forControlEvents:UIControlEventEditingChanged];
    [textField4 addTarget:self action:@selector(valueChange:) forControlEvents:UIControlEventEditingChanged];
    
    registButton = [RCRoundButton buttonWithType:UIButtonTypeCustom];
    registButton.frame = CGRectMake(ButtonMargin, 64 + 45 * [self.infos count] + ButtonGap * 2, ScreenWidth - ButtonMargin * 2, 40);
    registButton.tag = 6;
    [registButton setTitle:@"注册" forState:UIControlStateNormal];
    registButton.backgroundColor = [UIColor lightGrayColor];
    [registButton addTarget:self action:@selector(registButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    registButton.enabled = NO;
    [self.view addSubview:registButton];
    
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)valueChange:(UITextField *)textField{
    static BOOL b1 = NO,b2 = NO, b3 = NO, b4 = NO;
//    for (int i = 0 ; i < [self.infos count] ; i ++){
//        TextFieldValidator *textField = (TextFieldValidator *)[self.view viewWithTag:i + 1];
//        b = b & [textField validate];
//    }
    
    if (textField.tag == 1) {
        TextFieldValidator *tf = (TextFieldValidator *)textField;
        b1 = [tf validate];
    }
    
    if (textField.tag == 2) {
        TextFieldValidator *tf = (TextFieldValidator *)textField;
        b2 = [tf validate];
    }
    
    if (textField.tag == 3) {
        TextFieldValidator *tf = (TextFieldValidator *)textField;
        b3 = [tf validate];
    }
    
    if (textField.tag == 4) {
        TextFieldValidator *tf = (TextFieldValidator *)textField;
        b4 = [tf validate];
    }
    
    if (b1 & b2 & b3 & b4) {
        registButton.enabled = YES;
        registButton.backgroundColor = [UIColor getHexColor:@"F85C85"];
    }else{
        registButton.enabled = NO;
        registButton.backgroundColor = [UIColor lightGrayColor];// [UIColor getHexColor:@"F85C85"];
    }
}


-(void)registButtonClick:(id)sender{
    NSArray *keys = @[@"user",@"password",@"password2",@"phone",@"name"];
    NSMutableDictionary *dictionary =  [NSMutableDictionary dictionary];
    for (int i = 0 ; i < [self.infos count] ; i ++){
        UITextField *textField = (UITextField *)[self.view viewWithTag:i + 1];
        [dictionary setObject:textField.text forKey:[keys objectAtIndex:i]];
    }
    
    
    __block RegisterViewController *tempSelf = self;
    [[NetWork shared] startQuery:RegistUrl info:dictionary completeBlock:^(id Obj) {
        if ([Obj intForKey:@"status"] == 1) {
            [UserInfo shared].uid = [Obj strForKey:@"data"];
        }else{
            [tempSelf showMessage:[Obj strForKey:@"info"]];
        }
    }];
}


-(void)backButtonClick:(id)sender{
    [self dismissViewControllerAnimated:YES completion:^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"bringCustomTabBarToFront" object:nil];
    }];
}

@end
