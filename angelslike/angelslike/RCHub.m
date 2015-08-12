//
//  RCHub.m
//  AMTumblrHudDemo
//
//  Created by ridchan on 15/8/11.
//  Copyright (c) 2015年 askar. All rights reserved.
//

#import "RCHub.h"

#define PW 20 // point width

@implementation RoundHub


-(void)drawRect:(CGRect)rect{
//    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor blueColor].CGColor);
    CGContextAddEllipseInRect(context, rect);
    CGContextDrawPath(context, kCGPathFill);
    CGContextStrokePath(context);
}

@end

@implementation RCHub

+(instancetype)shared{
    static RCHub *hub = nil;
    static dispatch_once_t once = 0;
    dispatch_once(&once, ^{
        hub = [[RCHub alloc]init];
    });
    
    return hub;
}

+(void)show{

}


+(void)dismiss{
    
}

-(instancetype) init{
    if (self = [self initWithFrame:[[UIScreen mainScreen] bounds]]) {
        id<UIApplicationDelegate> delegate = [[UIApplication sharedApplication] delegate];

        if ([delegate respondsToSelector:@selector(window)])
            self.window = [delegate performSelector:@selector(window)];
        else self.window = [[UIApplication sharedApplication] keyWindow];
//        [self.window addSubview:self];
    }
    
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.bview =  [[UIView alloc]initWithFrame:CGRectMake(0, -100, 100, 100)];
        self.bview.backgroundColor = [UIColor lightGrayColor];
        self.bview.center = CGPointMake([[UIScreen mainScreen] bounds].size.width/2, [[UIScreen mainScreen] bounds].size.height/2);
        [self addSubview:self.bview];
//        [self buildView];
        [self initialSacleSetting:self.bview];
    }
    return self;
}

-(void)buildView{
    float width = self.bview.frame.size.width / 4;
    NSMutableArray *pointsArr = [NSMutableArray array];
    for (int i = 0 ; i < 3 ; i ++){
        CGPoint point = CGPointMake(width * (i + 1), self.bview.frame.size.height / 2);
        [pointsArr addObject:[NSValue valueWithCGPoint:point]];
    }
    
    for (int i = 0 ; i < 3 ; i ++){
        RoundHub *hub = [[RoundHub alloc]initWithFrame:CGRectMake(0, 0, PW, PW)];
        hub.center = [[pointsArr objectAtIndex:i] CGPointValue];
        hub.backgroundColor =  [UIColor clearColor];
        [self.bview addSubview:hub];
    }
    
    int i = 0;
    for (RoundHub *hub in self.bview.subviews){
        if ([hub isKindOfClass:[RoundHub class]]) {
            hub.transform = CGAffineTransformMakeScale(0.1, 0.1);
            float delay = 0.1 * i;
            
            [UIView animateWithDuration:0.5 delay:delay options:UIViewAnimationCurveEaseInOut | UIViewAnimationOptionAutoreverse | UIViewAnimationOptionRepeat animations:^{
                hub.transform = CGAffineTransformMakeScale(1.0, 1.0);
            } completion:nil];
            
            i++;
        }
    }
    
}


-(void)initialSacleSetting:(UIView *)bv{
    
    
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        float width = bv.frame.size.width / 4;
        NSMutableArray *pointsArr = [NSMutableArray array];
        for (int i = 0 ; i < 3 ; i ++){
            CGPoint point = CGPointMake(width * (i + 1), bv.frame.size.height / 2);
            [pointsArr addObject:[NSValue valueWithCGPoint:point]];
        }
        NSArray *colors = @[[UIColor redColor],[UIColor greenColor],[UIColor blueColor]];

        
        CALayer *layer = [CALayer new];
        layer.backgroundColor =  [[colors objectAtIndex:0] CGColor];
        layer.frame = CGRectMake(0, 0, PW , PW);
        layer.position = [[pointsArr objectAtIndex:0] CGPointValue];
        layer.cornerRadius = PW / 2;
        layer.masksToBounds = YES;
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [layer addAnimation:[self scaleAnimation:0.0] forKey:@"1"];
            [bv.layer addSublayer:layer];
        });
        
        
        CALayer *layer1 = [CALayer new];
        layer1.backgroundColor =  [[colors objectAtIndex:1] CGColor];
        layer1.frame = CGRectMake(0, 0, PW , PW);
        layer1.position = [[pointsArr objectAtIndex:1] CGPointValue];
        layer1.cornerRadius = PW / 2;
        layer1.masksToBounds = YES;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [layer1 addAnimation:[self scaleAnimation:0.2] forKey:@"2"];
            [bv.layer addSublayer:layer1];
        });
        
        
        CALayer *layer2 = [CALayer new];
        layer2.backgroundColor =  [[colors objectAtIndex:2] CGColor];
        layer2.frame = CGRectMake(0, 0, PW , PW);
        layer2.position = [[pointsArr objectAtIndex:2] CGPointValue];
        layer2.cornerRadius = PW / 2;
        layer2.masksToBounds = YES;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [layer2 addAnimation:[self scaleAnimation:0.4] forKey:@"3"];
            [bv.layer addSublayer:layer2];
        });
        

    });

}

-(void)initialMoveSetting{
    float width = self.frame.size.width / 4;
    NSMutableArray *pointsArr = [NSMutableArray array];
    for (int i = 0 ; i < 3 ; i ++){
        CGPoint point = CGPointMake(width * (i + 1), self.frame.size.height / 2);
        [pointsArr addObject:[NSValue valueWithCGPoint:point]];
    }
    NSArray *colors = @[[UIColor redColor],[UIColor greenColor],[UIColor blueColor]];
    for (int i = 0 ; i < 3 ; i ++){
        CALayer *layer = [CALayer new];
        layer.backgroundColor =  [[colors objectAtIndex:i] CGColor];
        layer.frame = CGRectMake(0, 0, PW , PW);
        NSValue *value = [pointsArr objectAtIndex:i];
        layer.position = [value CGPointValue];
        layer.cornerRadius = PW / 2;
        layer.masksToBounds = YES;
        if (i == 0) {
            [layer addAnimation:[self moveAnimations:@[[pointsArr objectAtIndex:0],[pointsArr objectAtIndex:1],[pointsArr objectAtIndex:2],[pointsArr objectAtIndex:1],[pointsArr objectAtIndex:0]]]
                         forKey:@"moves1"];
        }else if (i == 1){
//            [layer addAnimation:[self moveAnimations:@[[pointsArr objectAtIndex:1],[pointsArr objectAtIndex:2],[pointsArr objectAtIndex:1],[pointsArr objectAtIndex:0],[pointsArr objectAtIndex:1]]]
//                         forKey:@"moves2"];
        }else if (i == 2){
            [layer addAnimation:[self moveAnimations:@[[pointsArr objectAtIndex:2],[pointsArr objectAtIndex:1],[pointsArr objectAtIndex:0],[pointsArr objectAtIndex:1],[pointsArr objectAtIndex:2]]]
                         forKey:@"moves3"];
        }
//
        [self.layer addSublayer:layer];
    }
}

-(CABasicAnimation *)scaleAnimation:(float)duration{
    CABasicAnimation *an = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    an.duration = 0.5;
    an.repeatCount = 9999;
    an.autoreverses = YES;
    an.timeOffset = duration;
    an.fromValue = [NSNumber numberWithFloat:0.5];
    an.toValue = [NSNumber numberWithFloat:1.0];
    
    
    return an;
}

-(CAAnimation *)moveAnimations:(NSArray *)points{

    
    CAKeyframeAnimation * an = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    an.duration = 2.0;
    an.repeatCount = 9999;
    
    UIBezierPath *path = [UIBezierPath new];
    [path moveToPoint:[[points objectAtIndex:0] CGPointValue]];
    
    [path addLineToPoint:[[points objectAtIndex:1] CGPointValue]];
    [path addLineToPoint:[[points objectAtIndex:2] CGPointValue]];
    [path addLineToPoint:[[points objectAtIndex:3] CGPointValue]];
    [path addLineToPoint:[[points objectAtIndex:4] CGPointValue]];
    an.path = path.CGPath;
//    an.fromValue = [NSValue valueWithCGPoint:CGPointMake(100, 10)];
//    an.toValue = [NSValue valueWithCGPoint:CGPointMake(200, 10)];
    

    return an;
}

-(CABasicAnimation *)moveAnimation{
    CABasicAnimation *an = [CABasicAnimation animationWithKeyPath:@"position"];
    an.duration = 1.0;
    an.repeatCount = 9999;
    an.autoreverses = YES;
    an.fromValue = [NSValue valueWithCGPoint:CGPointMake(100, 10)];
    an.toValue = [NSValue valueWithCGPoint:CGPointMake(200, 10)];
    
    
    

    return an;
}

-(void)startAnimation{
    
}

-(void)stopAnimation{
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
