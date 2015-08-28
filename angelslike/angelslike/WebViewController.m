//
//  WebViewController.m
//  angelslike
//
//  Created by angelslike on 15/8/25.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import "WebViewController.h"

@implementation WebViewController

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)viewDidLoad{
    [super viewDidLoad];


}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    webView.scrollView.delegate = self;
    webView.scrollView.scrollEnabled = NO;
    scView  = webView.scrollView;
    [self.view addSubview:webView];
    
    NSMutableString *str = [NSMutableString stringWithString:self.content];
    [self reSizeImage:str];
    [webView loadHTMLString:str baseURL:[NSURL URLWithString:ImageLink]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(scrollViewCanMove:) name:@"SubScrollCanMove" object:nil];
}

-(void)scrollViewCanMove:(id)obj{
    scView.scrollEnabled = YES;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.y < 0) {
        scrollView.scrollEnabled = NO;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"MainScroll" object:[NSNumber numberWithBool:YES]];
    }

}


@end
