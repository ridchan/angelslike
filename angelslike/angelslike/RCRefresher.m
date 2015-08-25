//
//  RCRefresher.m
//  angelslike
//
//  Created by angelslike on 15/8/20.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import "RCRefresher.h"
#import <objc/runtime.h>


@implementation UIScrollView(RefreshHeader)

static const char HeaderKey = '\0';

-(void)setHeader:(RCRefresher *)header{
    if (header != self.header) {
        [self.header removeFromSuperview];
        [self addSubview:header];
        [self willChangeValueForKey:@"header"];
        objc_setAssociatedObject(self,&HeaderKey,header,OBJC_ASSOCIATION_ASSIGN);
        [self didChangeValueForKey:@"header"];
    }
}

-(RCRefresher *)header{
    return objc_getAssociatedObject(self, &HeaderKey);
}

@end


@implementation RCRefresher

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //
        self.clipsToBounds = YES;
        anView = [[UIView alloc]initWithFrame:CGRectMake(0, -frame.size.height, frame.size.width, frame.size.height)];
        [self initialSacleSetting:anView];
        [self addSubview:anView];
    }
    
    return self;
}

-(void)bindToView:(UIView *)v{
    if ([v isKindOfClass:[UIScrollView class]]) {
        _scrollView = (UIScrollView *)v;
        [_scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
        [_scrollView.panGestureRecognizer addObserver:self forKeyPath:@"state" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
        topInset = _scrollView.contentInset.top;
        _scrollView.contentInset = UIEdgeInsetsMake(topInset + 64, 0, 0, 0);
        
    }
}

-(void)beginRefresh{
    loading = YES;
}

-(void)endRefresh{
    loading = NO;
}


-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    
    static float offset = 0;
    static int type = 0;
    
    if (loading) {
        return;
    }
    if ([keyPath isEqualToString:@"state"]) {
        type = [[change objectForKey:@"new"] intValue];
        int oldtype = [[change objectForKey:@"old"] intValue];
        if (oldtype != type & type == 3) {
            if (offset < - topInset - 44) {
                [self startAnimation];
                loading = YES;
                NSLog(@"top insert %f", _scrollView.contentInset.top);
                _scrollView.contentInset = UIEdgeInsetsMake(topInset + 100, 0, 0, 0);
            }
        }
    }
    if ([keyPath isEqualToString:@"contentOffset"]) {
        offset = [[change objectForKey:@"new"] CGPointValue].y;
        
        if (type == 2) {
            
            if (offset < - topInset - 20) {
                [self show];
            }else{
                _scrollView.contentInset = UIEdgeInsetsMake(topInset , 0, 0, 0);
                [self dismiss];
            }
        }
    }
}


-(void)initialSacleSetting:(UIView *)bv{
    CGFloat PW = 16;
    self.layers = [NSMutableArray array];
    
    
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
    layer.position = CGPointMake(bv.frame.size.width / 2 - 50, bv.frame.size.height / 2);// [[pointsArr objectAtIndex:0] CGPointValue];
    layer.cornerRadius = PW / 2;
    layer.masksToBounds = YES;
    layer.name = @"1";
 
    [bv.layer addSublayer:layer];
    
    [self.layers addObject:layer];
    
    
    CALayer *layer1 = [CALayer new];
    layer1.backgroundColor =  [[colors objectAtIndex:1] CGColor];
    layer1.frame = CGRectMake(0, 0, PW , PW);
    layer1.position = CGPointMake(bv.frame.size.width / 2 , bv.frame.size.height / 2);//[[pointsArr objectAtIndex:1] CGPointValue];
    layer1.cornerRadius = PW / 2;
    layer1.name = @"2";
    layer1.masksToBounds = YES;
    
    [self.layers addObject:layer1];

    [bv.layer addSublayer:layer1];
    
    CALayer *layer2 = [CALayer new];
    layer2.backgroundColor =  [[colors objectAtIndex:2] CGColor];
    layer2.frame = CGRectMake(0, 0, PW , PW);
    layer2.position = CGPointMake(bv.frame.size.width / 2 + 50, bv.frame.size.height / 2);// [[pointsArr objectAtIndex:2] CGPointValue];
    layer2.cornerRadius = PW / 2;
    layer2.masksToBounds = YES;
    layer2.name = @"3";
    
    [bv.layer addSublayer:layer2];
    
    [self.layers addObject:layer2];

    
    
    
}

-(void)startAnimation{
    for (int i  = 0  ; i < [self.layers count] ; i ++){
        CALayer *layer = (CALayer *)[self.layers objectAtIndex:i];
        [layer addAnimation:[self scaleAnimation:i * 0.3] forKey:[NSString stringWithFormat:@"%d",i]];
    }
}

-(void)show{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    anView.frame = CGRectMake(0, 0, anView.frame.size.width, anView.frame.size.height);
    [UIView commitAnimations];
}

-(void)dismiss{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    anView.frame = CGRectMake(0, -anView.frame.size.height, anView.frame.size.width, anView.frame.size.height);
    [UIView commitAnimations];
    [self.layers makeObjectsPerformSelector:@selector(removeAllAnimations)];
}

-(CABasicAnimation *)scaleAnimation:(float)duration{
    CABasicAnimation *an = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    an.duration = 0.6;
    an.repeatCount = 9999;
    an.autoreverses = YES ;
    an.timeOffset = duration;
    
    an.fromValue = [NSNumber numberWithFloat:0.1];
    an.toValue = [NSNumber numberWithFloat:1.0];
    
    
    return an;
}


@end
