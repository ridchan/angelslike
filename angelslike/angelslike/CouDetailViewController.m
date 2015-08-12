//
//  CouDetailViewController.m
//  angelslike
//
//  Created by angelslike on 15/8/12.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import "CouDetailViewController.h"

@implementation CouDetailViewController

-(void)viewDidLoad{
    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    webView.delegate = self;
    webView.scalesPageToFit = NO;
    [self.view addSubview:webView];
    __block CouDetailViewController *tempSelf = self;
    __block UIWebView *tempView = webView;
    NSDictionary *dic = @{@"id":[self.info strForKey:@"id"],@"type":[self.info strForKey:@"type"],@"json":@"1"};
    [[NetWork shared]startQuery:CouDetailUrl info:dic completeBlock:^(id Obj) {
        NSDictionary *dic = [[Obj objectForKey:@"data"] objectForKey:@"items"];
        NSMutableString *str = [NSMutableString stringWithString:[dic strForKey:@"content"]];
        if ([str length] > 0) {
            [tempSelf reSizeImage:str];
            [tempView loadHTMLString:str baseURL:[NSURL URLWithString:@"http://www.angelslike.com/"]];
        }

    }];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
//    NSLog(@"webview %f %f",webView.pageLength,webView.scrollView.contentSize.height);
}

@end
