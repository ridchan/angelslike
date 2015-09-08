//
//  QtyButton.m
//  angelslike
//
//  Created by angelslike on 15/8/31.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import "QtyButton.h"

@implementation QtyButton

@synthesize qty = _qty;
@synthesize style = _style;
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame{
    if (self  = [super initWithFrame:frame]) {
        
        
        button1 = [UIButton buttonWithType:UIButtonTypeCustom];
        button1.backgroundColor  = [UIColor whiteColor];
        button1.titleLabel.font = FontWS(22);
        [button1 setTitle:@"-" forState:UIControlStateNormal];
        [button1 setTitleColor:[UIColor getHexColor:@"B8B8B8"] forState:UIControlStateNormal];
        button1.frame = CGRectMake(0, 0, frame.size.height, frame.size.height);
        [button1 addTarget:self action:@selector(button1Click:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button1];
        
        button2 = [UIButton buttonWithType:UIButtonTypeCustom];
        button2.backgroundColor = [UIColor whiteColor];
        button2.titleLabel.font = FontWS(22);
        [button2 setTitle:@"+" forState:UIControlStateNormal];
        [button2 setTitleColor:[UIColor getHexColor:@"B8B8B8"] forState:UIControlStateNormal];
        [button2 addTarget:self action:@selector(button2Click:) forControlEvents:UIControlEventTouchUpInside];
        button2.frame = CGRectMake(frame.size.width - frame.size.height, 0, frame.size.height, frame.size.height);
        [self addSubview:button2];
        
        label = [[UILabel alloc]initWithFrame:CGRectMake(frame.size.height, 0, frame.size.width - frame.size.height * 2, frame.size.height)];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"1";
        
        [self addSubview:label];
        
        
//        [self setRadio:self];
//        [self setRadio:button1];
//        [self setRadio:button2];
////        button1.layer.cornerRadius = frame.size.height / 2;
////        button1.layer.masksToBounds = YES;
////        button1.layer.borderColor = [UIColor getHexColor:@"E8E8E8"].CGColor;
////        button1.layer.borderWidth = 1.0;
////        
////        button1.layer.shadowColor = [UIColor blueColor].CGColor;// RGBA(0,0,0,1).CGColor;
////        button1.layer.shadowOffset = CGSizeMake(1.0, 2.0);
//        button1.transform = CGAffineTransformMakeScale(0.90,0.90);
//        button2.transform = CGAffineTransformMakeScale(0.90,0.90);
        
        
    }
    
    return self;
}


-(void)button1Click:(id)sender{
    NSString *nqty = [NSString stringWithFormat:@"%ld",[self.qty integerValue] - 1];
    self.qty = nqty;
    
}

-(void)button2Click:(id)sender{
    NSString *nqty = [NSString stringWithFormat:@"%ld",[self.qty integerValue] + 1];
    self.qty = nqty;
}

-(void)setStyle:(NSInteger)style{
    _style = style;
    if (style == 0) {
        self.backgroundColor = HexColor(@"F0EFEF");
        [self setRadio:self];
        [self setRadio:button1];
        [self setRadio:button2];
//        button1.layer.cornerRadius = frame.size.height / 2;
//        button1.layer.masksToBounds = YES;
//        button1.layer.borderColor = [UIColor getHexColor:@"E8E8E8"].CGColor;
//        button1.layer.borderWidth = 1.0;
//
//        button1.layer.shadowColor = [UIColor blueColor].CGColor;// RGBA(0,0,0,1).CGColor;
//        button1.layer.shadowOffset = CGSizeMake(1.0, 2.0);
        button1.transform = CGAffineTransformMakeScale(0.90,0.90);
        button2.transform = CGAffineTransformMakeScale(0.90,0.90);
    }else{
        self.layer.borderColor = RGBA(178, 177, 182, 0.8).CGColor;
        self.layer.borderWidth = 1.0;
        self.layer.cornerRadius = 4;
        label.layer.borderColor = RGBA(178, 177, 182, 0.8).CGColor;
        label.layer.borderWidth = 1.0;
    }
}

-(void)setRadio:(UIView *)v{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:v.bounds
                                                   byRoundingCorners:UIRectCornerAllCorners
                                                         cornerRadii:CGSizeMake(v.frame.size.height / 2, v.frame.size.height / 2)];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame         = v.bounds;
    maskLayer.path          = maskPath.CGPath;
    v.layer.mask         = maskLayer;
}


-(void)addTarget:(id)target action:(SEL)action{
    tar = target;
    act = action;
}


-(NSString *)qty{
    return label.text;
}

-(void)setQty:(NSString *)qty{
    _qty = qty;
    label.text = qty;
    if ([tar respondsToSelector:act]) {
        [tar performSelector:act withObject:_qty];
    }
}


@end
