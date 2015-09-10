//
//  CouProduct.m
//  angelslike
//
//  Created by angelslike on 15/8/14.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import "CouProduct.h"

@implementation CouProduct

@synthesize delegate = _delegate;

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, frame.size.width - 20, 200)];
//        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:imageView];
        
        nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 215, frame.size.width - 20, 30)];
        nameLabel.backgroundColor = [UIColor clearColor];
        nameLabel.font = FontWS(18);
        [self addSubview:nameLabel];
        
        priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(10 , 250, frame.size.width - 20, 30)];
        priceLabel.backgroundColor = [UIColor clearColor];
        priceLabel.textColor = [UIColor getHexColor:@"F44236"];
        priceLabel.font = FontWS(23);
        [self addSubview:priceLabel];
        
        UIColor *color = [UIColor getHexColor:@"F34336"];
        RCRoundButton *viewButton  =  [RCRoundButton buttonWithType:UIButtonTypeCustom];
        viewButton.radio = 20;
        viewButton.frame = CGRectMake(frame.size.width - 112, 245, 102, 40);
        
        viewButton.layer.borderColor = color.CGColor;
        viewButton.titleLabel.font = FontWS(15);
        [viewButton setTitleColor:color forState:UIControlStateNormal];
        [viewButton setTitle:@"查看详情" forState:UIControlStateNormal];
        [viewButton addTarget:self action:@selector(viewButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:viewButton];
        
        contentLabel = [[UIWebView alloc]initWithFrame:CGRectMake(10, 320, frame.size.width - 10, 1)];
        contentLabel.backgroundColor = [UIColor clearColor];
        contentLabel.delegate = self;
        contentLabel.scrollView.scrollEnabled = NO;
        [self addSubview:contentLabel];
        
    }
    return self;
}

-(void)viewButtonClick:(id)sender{
    if ([_delegate respondsToSelector:@selector(checkButtonClick:)]) {
        [_delegate performSelector:@selector(checkButtonClick:) withObject:sender];
    }
}

-(CAShapeLayer *)lineLayer:(CGPoint)position{
    CAShapeLayer *layer = [CAShapeLayer new];
    UIBezierPath *path = [UIBezierPath new];
    [path moveToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(ScreenWidth, 0)];
    
    layer.path = path.CGPath;
    layer.lineWidth = 0.5;
    layer.strokeColor = RGBA(178,177,182,.9).CGColor;
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.position = position;
    return layer;
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    
    //24,24,27,.8
    NSString *strColor = [NSString stringWithFormat:@"document.getElementsByTagName('body')[0].style.webkitTextFillColor='gray'"];
    
    [webView stringByEvaluatingJavaScriptFromString:strColor];
    
    NSString *htmlHeight = [webView stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight"];
    contentLabel.frame = CGRectMake(5, 320, contentLabel.frame.size.width, [htmlHeight floatValue]);
    
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, 320 + [htmlHeight floatValue] + 10);
    
    [self.layer addSublayer:[self lineLayer:CGPointMake(0, 1)]];
//    [self.layer addSublayer:[self lineLayer:CGPointMake(0, imageView.frame.origin.y + imageView.frame.size.height + 5)]];
    [self.layer addSublayer:[self lineLayer:CGPointMake(0, self.frame.size.height - 1)]];
    
    if ([_delegate respondsToSelector:@selector(beResize:)]) {
        [_delegate performSelector:@selector(beResize:) withObject:[NSValue valueWithCGRect:self.frame]];
    }
}

-(CGRect)setImg:(NSString *)link name:(NSString *)name price:(NSString *)price content:(NSString *)content{
    
//    __block UILabel *tempName = nameLabel;
//    __block UILabel *tempPrice = priceLabel;
//    __block UIImageView *tempImage = imageView;
//    __block UIWebView *tempContent = contentLabel;
    [imageView setPreImageWithUrl:link block:^(id Obj) {
//        (10, 215, frame.size.width - 20, 30)
//        tempName.frame = CGRectMake(10, tempImage.frame.size.height + tempImage.frame.origin.y + 5, tempImage.frame.size.width, tempImage.frame.size.height);
//        tempPrice.frame = CGRectMake(10, tempName.frame.size.height + tempName.frame.origin.y + 5, tempName.frame.size.width, tempName.frame.size.height);
//        tempContent.frame = CGRectMake(10, tempName.frame.size.height + tempName.frame.origin.y + 5, tempName.frame.size.width, tempName.frame.size.height);
    }];
    
    nameLabel.text = name;
    priceLabel.text = [NSString stringWithFormat:@"￥%@",price];
    [contentLabel loadHTMLString:content baseURL:nil];
    
    
//    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, rect.origin.y + rect.size.height);
    
//    if([_delegate respondsToSelector:@selector(beResize:)]){
//        [_delegate performSelector:@selector(beResize:) withObject:[NSValue valueWithCGRect:self.frame]];
//    }
    
    return self.frame;
}

@end
