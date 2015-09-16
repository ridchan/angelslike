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
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [self initialSetting];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [_searchBar becomeFirstResponder];
}

-(void)initialSetting{
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelClick:)];
    rightButton.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = rightButton;

    
    _searchBar  = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, 100, 28)];
    _searchBar.barStyle = UIBarStyleDefault;
    _searchBar.backgroundColor = [UIColor clearColor];
    _searchBar.tintColor = [UIColor clearColor];
    _searchBar.delegate  = self;
    self.navigationItem.titleView.backgroundColor = [UIColor clearColor];
    self.navigationItem.titleView = _searchBar;
    
//    [self.navigationItem.backBarButtonItem setTitle:@""];
    [self.navigationItem setHidesBackButton:YES];
    
    
}



-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [_searchBar resignFirstResponder];
    [self.navigationItem setHidesBackButton:NO];
}

-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    _searchBar.frame =  CGRectMake(0, 0, 100, 28);
    [self.navigationItem setHidesBackButton:YES];
    return YES;
}

-(BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar{
    [self.navigationItem setHidesBackButton:NO];
    return YES;
}


-(void)cancelClick:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)backClick:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
