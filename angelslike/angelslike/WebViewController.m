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
    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:webView];

    [webView loadHTMLString:self.content baseURL:nil];

}


@end
