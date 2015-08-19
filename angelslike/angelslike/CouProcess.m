//
//  CouProcess.m
//  angelslike
//
//  Created by angelslike on 15/8/14.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import "CouProcess.h"

@implementation CouProcess

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        img1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
        img1.image =  [UIImage imageNamed:@"iconfont-mubiao"];
        img2 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
        img2.image =  [UIImage imageNamed:@"iconfont-wancheng"];
        
//        [self.layer addSublayer:[self lineLayer:CGPointMake(0, 5)]];
        [self.layer addSublayer:[self lineLayer:CGPointMake(0, 40)]];
        [self.layer addSublayer:[self vlineLayer:CGPointMake(frame.size.width / 2, 5)]];
        
        
        label1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, frame.size.width/2, 40)];
        label1.backgroundColor = [UIColor clearColor];
        label1.textAlignment = NSTextAlignmentCenter;
        label1.font = FontWS(11);
        
        label2 = [[UILabel alloc]initWithFrame:CGRectMake(frame.size.width/2, 0, frame.size.width/2, 40)];
        label2.backgroundColor = [UIColor clearColor];
        label2.textAlignment = NSTextAlignmentCenter;
        label2.font = FontWS(11);
        
        progress = [[ProgressView alloc]initWithFrame:CGRectMake(ScreenWidth / 2 - 40, 55 , 80, 80)];
        
        progress.arcBackColor = [UIColor getHexColor:@"f2f2f2"];
        progress.arcUnfinishColor = [UIColor getHexColor:@"fa7a7a"];
        progress.arcFinishColor  = [UIColor getHexColor:@"fa7a7a"];
        [self addSubview:progress];
        
        [self addSubview:img1];
        [self addSubview:img2];
        [self addSubview:label1];
        [self addSubview:label2];
    }
    
    return self;
}


-(void)setTarget:(NSString *)target complete:(NSString *)complete{

    label1.text = [NSString stringWithFormat:@"目标%@份",target];
    label2.text = [NSString stringWithFormat:@"已完成%@份",complete];
    
    CGSize size1 = [label1.text sizeWithAttributes:@{NSFontAttributeName:label1.font}];
    CGSize size2 = [label2.text sizeWithAttributes:@{NSFontAttributeName:label2.font}];
    
    img1.center = CGPointMake(label1.center.x - size1.width / 2 - 10,label1.center.y);
    img2.center = CGPointMake(label2.center.x - size2.width / 2 - 10,label2.center.y);
    
    if ([target floatValue] > 0) {
        progress.percent = [complete floatValue] / [target floatValue];
    }
    
}

-(CAShapeLayer *)vlineLayer:(CGPoint)position{
    CAShapeLayer *layer = [CAShapeLayer new];
    UIBezierPath *path = [UIBezierPath new];
    [path moveToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(0, 30)];
    
    
    layer.path = path.CGPath;
    layer.lineWidth = 0.5;
    layer.strokeColor = RGBA(178,177,182,.9).CGColor;
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.position = position;
    return layer;
}

-(CAShapeLayer *)lineLayer:(CGPoint)position{
    CAShapeLayer *layer = [CAShapeLayer new];
    UIBezierPath *path = [UIBezierPath new];
    [path moveToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(ScreenWidth, 0)];
    
    
    layer.path = path.CGPath;
    layer.lineWidth = 0.5;
    layer.strokeColor = [UIColor lightGrayColor].CGColor;
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.position = position;
    return layer;
}





@end
