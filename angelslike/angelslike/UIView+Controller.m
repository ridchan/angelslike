//
//  UIView+Controller.m
//  angelslike
//
//  Created by angelslike on 15/9/8.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import "UIView+Controller.h"

@implementation UIView (Controller)

- (UIViewController *)findViewController:(UIView *)sourceView
{
    id target=sourceView;
    while (target) {
        target = ((UIResponder *)target).nextResponder;
        if ([target isKindOfClass:[UIViewController class]]) {
            break;
        }
    }
    return target;
}

-(void)addline:(CGPoint)point color:(UIColor *)color{
    CAShapeLayer *layer = [CAShapeLayer new];
    UIBezierPath *path = [UIBezierPath new];
    [path moveToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(self.frame.size.width, 0)];
    
    
    layer.path = path.CGPath;
    layer.lineWidth = 0.5;
    layer.strokeColor = color?color.CGColor:[UIColor colorWithRed:(float)(178/255.0f)green:(float)(177 / 255.0f) blue:(float)(182 / 255.0f)alpha:0.9].CGColor;
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.position = point;
    [self.layer addSublayer:layer];
}

@end
