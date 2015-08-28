//
//  ProductHeader.m
//  angelslike
//
//  Created by angelslike on 15/8/28.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import "ProductHeader.h"

@implementation ProductHeader

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //
        self.backgroundColor = [UIColor clearColor];
        backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        backView.backgroundColor = [UIColor whiteColor];
        backView.alpha = 0.1;
        [self addSubview:backView];
        
        CGFloat buttongap = 8;
        CGFloat buttonwidth = frame.size.height - buttongap * 2;
        
        
        button1 = [RCRoundButton buttonWithType:UIButtonTypeCustom];
        button1.tag = 1;
        button1.bRound = YES;
        button1.frame = CGRectMake(buttongap, buttongap, buttonwidth, buttonwidth);
        button1.backgroundColor = RGBA(245,245,245,.4);
        [button1 addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        img1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 18, 18)];
        img1.contentMode = UIViewContentModeScaleAspectFit;
        img1.center = button1.center;
        img1.image = [[UIImage imageNamed:@"iconfont-houtui"] rt_tintedImageWithColor:[UIColor getHexColor:@"2B2B2B"]];
        
        
        [self addSubview:button1];
        [self addSubview:img1];
        
        //
        button2 = [RCRoundButton buttonWithType:UIButtonTypeCustom];
        button2.tag = 2;
        button2.bRound = YES;
        button2.backgroundColor = RGBA(245,245,245,.4);
        button2.frame = CGRectMake(frame.size.width - (buttongap + buttonwidth) * 3, buttongap, buttonwidth, buttonwidth);
        [button2 addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        img2 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 18, 18)];
        img2.contentMode = UIViewContentModeScaleAspectFit;
        img2.center = button2.center;
        img2.image = [[UIImage imageNamed:@"iconfont-gouwuche"] rt_tintedImageWithColor:[UIColor getHexColor:@"2B2B2B"]];
        
        [self addSubview:button2];
        [self addSubview:img2];
        //
        button3 = [RCRoundButton buttonWithType:UIButtonTypeCustom];
        button3.tag = 3;
        button3.bRound = YES;
        button3.backgroundColor = RGBA(245,245,245,.4);
        button3.frame = CGRectMake(frame.size.width - (buttongap + buttonwidth) * 2, buttongap, buttonwidth, buttonwidth);
        [button3 addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        img3 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 18, 18)];
        img3.contentMode = UIViewContentModeScaleAspectFit;
        img3.center = button3.center;
        img3.image = [[UIImage imageNamed:@"iconfont-kongxi"] rt_tintedImageWithColor:[UIColor getHexColor:@"2B2B2B"]];
        
        [self addSubview:button3];
        [self addSubview:img3];
        //
        button4 = [RCRoundButton buttonWithType:UIButtonTypeCustom];
        button4.tag = 4;
        button4.bRound = YES;
        button4.backgroundColor = RGBA(245,245,245,.4);
        button4.frame = CGRectMake(frame.size.width - buttongap - buttonwidth, buttongap, buttonwidth, buttonwidth);
        [button4 addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        img4 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 18, 18)];
        img4.contentMode = UIViewContentModeScaleAspectFit;
        img4.center = button4.center;
        img4.image = [[UIImage imageNamed:@"iconfont-fenxiang"] rt_tintedImageWithColor:[UIColor getHexColor:@"2B2B2B"]];
        
        [self addSubview:button4];
        [self addSubview:img4];
        
        line = [self lineLayer:CGPointMake(0, frame.size.height)];
        line.opacity = 0.0;
        [self.layer addSublayer:line];
    }
    return self;
}

-(void)buttonClick:(id)sender{
    if ([target respondsToSelector:action]) {
        [target performSelector:action withObject:sender];
    }
}

-(void)addTarget:(id)tar action:(SEL)act{
    target = tar;
    action = act;
}


-(void)setAlpha:(CGFloat)alpha{
    backView.alpha = alpha + 0.1;

    line.opacity = alpha >= 1 ? 1 : 0;
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

@end
