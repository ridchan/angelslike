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

//-(void)webViewDidFinishLoad:(UIWebView *)webView{
//    [webView stringByEvaluatingJavaScriptFromString:
//     @"var script = document.createElement('script');"
//     "script.type = 'text/javascript';"
//     "script.text = \"function ResizeImages() { "
//     "var myimg,oldwidth;"
//     "var maxwidth=320;" //缩放系数
//     "for(i=0;i <document.images.length;i++){"
//     "myimg = document.images[i];"
//     "if(myimg.width > maxwidth){"
//     "oldwidth = myimg.width;"
//     "myimg.width = maxwidth;"
//     "myimg.height = myimg.height * (maxwidth/oldwidth);"
//     "}"
//     "}"
//     "}\";"
//     "document.getElementsByTagName('head')[0].appendChild(script);"];
//    
//    [webView stringByEvaluatingJavaScriptFromString:@"ResizeImages();"];
//}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    webView.scrollView.delegate = self;
    webView.delegate = self;
//    webView.scrollView.scrollEnabled = NO;
    scView  = webView.scrollView;
    [self.view addSubview:webView];

    NSMutableString *str = [NSMutableString stringWithString:self.content];
//    [self reSizeImage:str];
    [webView loadHTMLString:str baseURL:[NSURL URLWithString:img1Url]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(scrollViewCanMove:) name:@"SubScrollCanMove" object:nil];
    
    canMove = NO;
}

-(void)scrollViewCanMove:(NSNotification *)obj{

    scView.scrollEnabled = YES;
    [scView becomeFirstResponder];
    
}



-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.y < 0 && scrollView.scrollEnabled) {
        scrollView.scrollEnabled = NO;
        [scrollView resignFirstResponder];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"MainScroll" object:nil];
    }

}





@end
