//
//  CouPay.m
//  angelslike
//
//  Created by angelslike on 15/8/28.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import "CouPay.h"

@implementation CouPay

-(instancetype)init{
    if (self = [super initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)]) {
        self.backgroundColor = [UIColor clearColor];
        
        backView = [[UIView alloc]initWithFrame:self.frame];
        backView.backgroundColor = [UIColor blackColor];
        backView.alpha = 0.0;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss)];
        [backView addGestureRecognizer:tap];
        [self addSubview:backView];
        
        payView = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight, ScreenWidth, 250)];
        payView.backgroundColor = [UIColor whiteColor];
        
        
        self.hidden = YES;
        [self addSubview:payView];
        
        [self setPayView];
        
        
        
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}

-(void)keyboardShow:(id)obj{
    [UIView animateWithDuration:0.35 animations:^{
        payView.frame = CGRectMake(0, ScreenHeight - 250 - 250, ScreenWidth, 250);
    }];
}

-(void)keyboardHide:(id)obj{
    [UIView animateWithDuration:0.35 animations:^{
        payView.frame = CGRectMake(0, ScreenHeight - 250 , ScreenWidth, 250);
    }];
}

-(void)setPayView{
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, ScreenWidth - 20, 50)];
    label1.text = @"是否匿名凑";
    
    [payView.layer addSublayer:[self lineLayer:CGPointMake(0, 50)]];
    
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 50, ScreenWidth - 20, 50)];
    label2.text = @"支付方式";
    
    [payView.layer addSublayer:[self lineLayer:CGPointMake(0, 100)]];
    
    UILabel *label3 = [[UILabel alloc]initWithFrame:CGRectMake(10, 100, ScreenWidth - 20, 50)];
    label3.text = @"说点什么(必填)";
    
    UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(ScreenWidth / 2 - 10, 110, ScreenWidth / 2, 30)];
    textField.borderStyle = UITextBorderStyleRoundedRect;
    [payView addSubview:textField];
    
    [payView.layer addSublayer:[self lineLayer:CGPointMake(0, 150)]];
    
    UILabel *label4 = [[UILabel alloc]initWithFrame:CGRectMake(10, 150, ScreenWidth - 20, 50)];
    label4.text = @"应付￥7元";
    
    UIButton *submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    submitButton.frame = CGRectMake(0, 200, ScreenWidth, 50);
    [submitButton setTitle:@"提交订单" forState:UIControlStateNormal];
    [submitButton setBackgroundColor:[UIColor getHexColor:@"F85C85"]];
    
    [payView addSubview:label1];
    [payView addSubview:label2];
    [payView addSubview:label3];
    [payView addSubview:label4];
    [payView addSubview:submitButton];
    
}

-(void)show{
    [[self superview] bringSubviewToFront:self];
    self.hidden = NO;
    [UIView animateWithDuration:0.35 animations:^{
        backView.alpha = 0.4;
        payView.frame = CGRectMake(0, ScreenHeight - 250, ScreenWidth, 250);
    }];
}

-(void)dismiss{
    
    [UIView animateWithDuration:.35 animations:^{
        backView.alpha = 0.0;
        payView.frame = CGRectMake(0, ScreenHeight, ScreenWidth, 250);
    } completion:^(BOOL finished) {
        self.hidden = YES;
    }];
    
//    [self removeFromSuperview];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
