//
//  WebViewController.m
//  angelslike
//
//  Created by angelslike on 15/8/25.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import "WebViewController.h"

@implementation WebViewController

-(void)viewDidLoad{
    [super viewDidLoad];


}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    [self.view addSubview:webView];
    NSMutableString *str = [NSMutableString stringWithString:self.content];
    [self reSizeImage:str];
    [webView loadHTMLString:str baseURL:[NSURL URLWithString:@"http://www.angelslike.com"]];
}


@end
