//
//  SearchViewController.m
//  angelslike
//
//  Created by angelslike on 15/8/6.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import "SearchViewController.h"

@implementation SearchViewController


-(void)viewDidLoad{
    [super viewDidLoad];
    [self initialSetting];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [searchBar becomeFirstResponder];
}

-(void)initialSetting{
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelClick:)];
    rightButton.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = rightButton;

    
    searchBar  = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, 100, 28)];
    searchBar.barStyle = UIBarStyleDefault;
    searchBar.backgroundColor = [UIColor clearColor];
    searchBar.tintColor = [UIColor clearColor];
    searchBar.delegate  = self;
    self.navigationItem.titleView.backgroundColor = [UIColor clearColor];
    self.navigationItem.titleView = searchBar;
    
//    [self.navigationItem.backBarButtonItem setTitle:@""];
    [self.navigationItem setHidesBackButton:YES];
    
    
}


-(void)cancelClick:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)backClick:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
