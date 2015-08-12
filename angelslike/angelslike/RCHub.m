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



@end

@implementation RCHub

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self initialSetting];
    }
    return self;
}

-(void)initialSetting{
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
