//
//  CouViewController.m
//  angelslike
//
//  Created by ridchan on 15/8/6.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import "CouViewController.h"

@interface CouViewController ()

@end

@implementation CouViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UISegmentedControl *seg = [[UISegmentedControl alloc]initWithItems:@[@"谁在凑分子",@"我的凑分子"]];
    seg.tintColor = [UIColor whiteColor];
    self.navigationItem.titleView = seg;

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
