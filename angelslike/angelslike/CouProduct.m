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
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 10, frame.size.width - 10, 200)];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:imageView];
        
        nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 215, frame.size.width -10, 30)];
        nameLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:nameLabel];
        
        priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(5 , 250, frame.size.width - 10, 30)];
        priceLabel.backgroundColor = [UIColor clearColor];
        priceLabel.textColor = [UIColor redColor];
        [self addSubview:priceLabel];
        
        UIColor *color = [UIColor getHexColor:@"F34336"];
        RCRoundButton *viewButton  =  [RCRoundButton buttonWithType:UIButtonTypeCustom];
        viewButton.radio = 15;
        viewButton.frame = CGRectMake(frame.size.width - 100, 250, 80, 30);
        
        viewButton.layer.borderColor = color.CGColor;
        viewButton.titleLabel.font = FontWS(12);
        [viewButton setTitleColor:color forState:UIControlStateNormal];
        [viewButton setTitle:@"查看详情" forState:UIControlStateNormal];
        [viewButton addTarget:self action:@selector(viewButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:viewButton];
        
        contentLabel = [[UIWebView alloc]initWithFrame:CGRectMake( 5 , 285, frame.size.width - 10, 1)];
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
    NSString *htmlHeight = [webView stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight"];
    contentLabel.frame = CGRectMake(5, 285, contentLabel.frame.size.width, [htmlHeight floatValue]);
    
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, 285 + [htmlHeight floatValue] + 10);
    
    [self.layer addSublayer:[self lineLayer:CGPointMake(0, 1)]];
    [self.layer addSublayer:[self lineLayer:CGPointMake(0, imageView.frame.origin.y + imageView.frame.size.height + 5)]];
    [self.layer addSublayer:[self lineLayer:CGPointMake(0, self.frame.size.height - 1)]];
    
    if ([_delegate respondsToSelector:@selector(beResize:)]) {
        [_delegate performSelector:@selector(beResize:) withObject:[NSValue valueWithCGRect:self.frame]];
    }
}

-(CGRect)setImg:(NSString *)link name:(NSString *)name price:(NSString *)price content:(NSString *)content{
    [imageView sd_setImageWithURL:[NSURL URLWithString:link]];
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
