//
//  LoginViewController.h
//  angelslike
//
//  Created by angelslike on 15/8/10.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import "BaseViewController.h"
#import "RegisterViewController.h"
#import "TabBarViewController.h"
#import "WXApi.h"

@interface LoginViewController : BaseViewController

@property(nonatomic,strong) UITextField *nameField;
@property(nonatomic,strong) UITextField *psdField;

@property(nonatomic,weak) UITabBarController *bvc;

@end
