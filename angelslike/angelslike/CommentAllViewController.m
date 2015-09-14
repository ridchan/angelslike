//
//  CommentAllViewController.m
//  angelslike
//
//  Created by angelslike on 15/9/14.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import "CommentAllViewController.h"

@interface CommentAllViewController ()

@end

@implementation CommentAllViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBackButtonAction:@selector(backClick:)];
    NSLog(@"self info %@",self.info);
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)backClick:(id)obj{
    [self.navigationController dismissViewControllerAnimated:YES completion:NULL];
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
