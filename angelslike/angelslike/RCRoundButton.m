//
//  RCRoundButton.m
//  iCar
//
//  Created by  APPLE on 2015/7/9.
//  Copyright (c) 2015年  APPLE. All rights reserved.
//

#import "RCRoundButton.h"
#import <QuartzCore/QuartzCore.h>

@implementation RCRoundButton

-(void)setCorner:(CGFloat)corner{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                   byRoundingCorners:UIRectCornerAllCorners
                                                         cornerRadii:CGSizeMake(corner, corner)];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame         = self.bounds;
    maskLayer.path          = maskPath.CGPath;
    self.layer.mask         = maskLayer;
}

-(void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    CGFloat radii = 5.0;
    if (self.radio > 0) {
        radii = self.radio;
        self.layer.borderWidth = 1.0;
        self.layer.cornerRadius = radii;
    }
    if (self.bRound) {
        radii = frame.size.width / 2;
    }
    
    [self setCorner:radii];
    
}

-(void)awakeFromNib{
    [super awakeFromNib];
    

    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                   byRoundingCorners:UIRectCornerAllCorners
                                                         cornerRadii:CGSizeMake(5.0, 5.0)];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame         = self.bounds;
    maskLayer.path          = maskPath.CGPath;
    self.layer.mask         = maskLayer;
}

@end
