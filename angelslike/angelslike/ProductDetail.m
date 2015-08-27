//
//  ProductDetail.m
//  angelslike
//
//  Created by angelslike on 15/8/25.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import "ProductDetail.h"

@implementation ProductDetail

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.width  * 9 / 16)];
        [self addSubview:imageView];
        
        namelabel = [[UILabel alloc]initWithFrame:CGRectMake(5, imageView.frame.size.height, frame.size.width - 10, 30)];
        namelabel.backgroundColor = [UIColor clearColor];
        [self addSubview:namelabel];
        
        pricelabel = [[UILabel alloc]initWithFrame:CGRectMake(5, namelabel.frame.origin.y + namelabel.frame.size.height , frame.size.width - 10, 30)];
        pricelabel.backgroundColor = [UIColor clearColor];
        pricelabel.textColor = [UIColor redColor];
        [self addSubview:pricelabel];
        
        content = [[UIWebView alloc]initWithFrame:CGRectMake(5, pricelabel.frame.origin.y + pricelabel.frame.size.height , frame.size.width - 10, 30)];
        content.scrollView.scrollEnabled = NO;
//        content.backgroundColor = [UIColor clearColor];
//        content.scrollView.backgroundColor = [UIColor clearColor];
        content.delegate = self;
        [self addSubview:content];
    }
    
    return self;
}

-(void)setInfo:(NSDictionary *)info{
    [imageView setPreImageWithUrl:[info strForKey:@"img"]];
    namelabel.text = [info strForKey:@"name"];
    pricelabel.text = [NSString stringWithFormat:@"￥%@",[info strForKey:@"price"]];
    
    [content loadHTMLString:[info strForKey:@"content"] baseURL:[NSURL URLWithString:MainUrl]];
    

}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.webkitTextFillColor= 'gray'"];
    
    CGRect rect = webView.frame;
    
    NSString *htmlHeight = [webView stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight"];
    webView.frame = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, [htmlHeight floatValue]);
    self.frame = CGRectMake(self.frame.origin.x,self.frame.origin.y , self.frame.size.width,  webView.frame.origin.y + webView.frame.size.height);
}

@end
