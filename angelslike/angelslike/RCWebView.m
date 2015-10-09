//
//  RCWebView.m
//  angelslike
//
//  Created by angelslike on 15/10/9.
//  Copyright © 2015年 angelslike. All rights reserved.
//

#import "RCWebView.h"

@implementation RCWebView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)setText:(NSString *)text{
    self.delegate = self;
    [self loadHTMLString:text baseURL:nil];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    NSString *htmlHeight = [webView stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight"];
    NSString *htmlWidth = [webView stringByEvaluatingJavaScriptFromString:@"document.body.scrollWidth"];
    if ([htmlWidth floatValue] > ScreenWidth){ //  图片转换实际高度
        float height = ScreenWidth * [htmlHeight floatValue] / [htmlWidth floatValue];
        htmlHeight = [NSString stringWithFormat:@"%f",height];
    }
    CGRect rect = CGRectZero;
    rect.origin = self.frame.origin;
    rect.size = CGSizeMake(self.frame.size.width, [htmlHeight floatValue]);
    self.frame = rect;
    if(_block) _block([NSString stringWithFormat:@"%f",MaxY(self)]);
}

@end
