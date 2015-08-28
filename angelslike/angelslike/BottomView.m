//
//  BottomView.m
//  angelslike
//
//  Created by angelslike on 15/8/28.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import "BottomView.h"

@implementation BottomView


-(instancetype)initWithFrame:(CGRect)frame{
    if ( self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        [self.layer addSublayer:[self lineLayer:CGPointMake(0, 0)]];
        [self.layer addSublayer:[self vlineLayer:CGPointMake(frame.size.width / 3, 5)]];
        [self.layer addSublayer:[self vlineLayer:CGPointMake(frame.size.width / 3 * 2, 5)]];
        
        button1 = [UIButton buttonWithType:UIButtonTypeCustom];
        button1.frame = CGRectMake(0, 0, frame.size.width / 3, frame.size.height);
        [button1 addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        button1.tag = 1;
        [self addSubview:button1];
        
        button2 = [UIButton buttonWithType:UIButtonTypeCustom];
        button2.frame = CGRectMake(frame.size.width / 3, 0, frame.size.width / 3, frame.size.height);
        [button2 addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        button2.tag = 2;
        [self addSubview:button2];
        
        button3 = [UIButton buttonWithType:UIButtonTypeCustom];
        button3.frame = CGRectMake(frame.size.width / 3 * 2, 0, frame.size.width / 3, frame.size.height);
        [button3 addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        button3.tag = 3;
        [self addSubview:button3];
        
        [self setContent];
    }
    return self;
}

-(void)setContent{
    img1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    img1.contentMode = UIViewContentModeScaleAspectFit;
    img1.image = [UIImage imageNamed:@"iconfont-kongxi"];
    img1.center = CGPointMake(button1.center.x - 10, button1.center.y) ;
    
    img2 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    img2.contentMode = UIViewContentModeScaleAspectFit;
    img2.image = [UIImage imageNamed:@"iconfont-pinglun"];
    img2.center = CGPointMake(button2.center.x - 10, button2.center.y);
    
    img3= [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    img3.contentMode = UIViewContentModeScaleAspectFit;
    img3.image = [UIImage imageNamed:@"iconfont-fenxiang-r"];
    img3.center = CGPointMake(button3.center.x - 10, button3.center.y);
    
    [self addSubview:img1];
    [self addSubview:img2];
    [self addSubview:img3];
    
    
    label1 = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width / 6 + 5, 0, self.frame.size.width / 6 - 5, self.frame.size.height)];
    label1.textColor = [UIColor getHexColor:@"767676"];
    label1.text = @"0";
    label2 = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width / 2 + 5, 0, self.frame.size.width / 6 - 5, self.frame.size.height)];
    label2.textColor = [UIColor getHexColor:@"767676"];
    label2.text = @"0";
    label3 = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width / 6 * 5 + 5, 0, self.frame.size.width / 6 - 5, self.frame.size.height)];
    label3.textColor = [UIColor getHexColor:@"767676"];
    label3.text = @"0";
    
    [self addSubview:label1];
    [self addSubview:label2];
    [self addSubview:label3];
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

-(void)setCount:(NSString *)str count2:(NSString *)str2 count3:(NSString *)str3{
    label1.text = str;
    label2.text = str2;
    label3.text = str3;
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

-(CAShapeLayer *)vlineLayer:(CGPoint)position{
    CAShapeLayer *layer = [CAShapeLayer new];
    UIBezierPath *path = [UIBezierPath new];
    [path moveToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(0, self.frame.size.height - 10)];
    
    
    layer.path = path.CGPath;
    layer.lineWidth = 0.5;
    layer.strokeColor = RGBA(178,177,182,.9).CGColor;
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.position = position;
    return layer;
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
