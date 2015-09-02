//
//  CircleButton.m
//  angelslike
//
//  Created by angelslike on 15/9/2.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import "CircleButton.h"

@implementation CircleButton
@synthesize bRotation = _bRotation;

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        imageView.image = [UIImage imageNamed:@"receiving-round"];
        [self addSubview:imageView];
        
        UIView *b1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height / 2)];
        b1.backgroundColor = [UIColor clearColor];
        b1.tag = 101;
        [self setButton:b1 name:@"本人填" tag:1];
        [self addSubview:b1];
        

        UIView *b2 = [[UIView alloc]initWithFrame:CGRectMake(0, frame.size.height / 2, frame.size.width, frame.size.height / 2)];
        b2.backgroundColor = [UIColor clearColor];
        b2.tag = 102;
        [self setButton:b2 name:@"让Ta填" tag:2];
        [self addSubview:b2];
    }
    return self;
}

-(void)setButton:(UIView *)view name:(NSString *)name tag:(NSUInteger)tag{
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);
    button1.tag = tag;
    [button1 addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    UILabel *label1 = [[UILabel alloc]initWithFrame:button1.frame];
    label1.backgroundColor =  [UIColor clearColor];
    label1.textAlignment = NSTextAlignmentCenter;
    label1.textColor = [UIColor whiteColor];
    label1.font = [UIFont boldSystemFontOfSize:16];
    label1.text = name;
    
    [view addSubview:label1];
    [view addSubview:button1];
}

-(void)buttonClick:(UIButton *)button{
    if ([tar respondsToSelector:act]) {
        [tar performSelector:act withObject:button];
    }
}

-(void)addTarget:(id)target action:(SEL)action{
    tar = target;
    act = action;
}

-(void)startAnimation:(BOOL)rotation{
    if (rotation) {
        CGRect rect = [self viewWithTag:101].frame;
        [self viewWithTag:101].frame = [self viewWithTag:102].frame;
        [self viewWithTag:102].frame = rect;
    }
    [self.layer addAnimation:[self animation] forKey:@"rotation"];
}

-(void)setBRotation:(BOOL)bRotation{
    _bRotation = bRotation;
    CGRect rect = [self viewWithTag:101].frame;
    [self viewWithTag:101].frame = [self viewWithTag:102].frame;
    [self viewWithTag:102].frame = rect;
}

-(CABasicAnimation *)animation{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    
    // 设定动画选项
    animation.duration = 1.0     ; // 持续时间
    animation.repeatCount = 1; // 重复次数
    
    // 设定旋转角度
    animation.fromValue = [NSNumber numberWithFloat:0.0]; // 起始角度
    animation.toValue = [NSNumber numberWithFloat:2 * M_PI]; // 终止角度
    
    // 添加动画
    return animation;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
