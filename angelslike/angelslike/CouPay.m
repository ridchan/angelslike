//
//  CouPay.m
//  angelslike
//
//  Created by angelslike on 15/8/28.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import "CouPay.h"

@implementation CouPay

@synthesize info = _info;

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
        
        
        
//        
//        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
//        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
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
    
    CheckButton *cb1 = [[CheckButton alloc]initWithFrame:CGRectMake(ScreenWidth - 40, 9, 50, 32)];
    cb1.tag = 1;
    cb1.canUnselected = YES;
    [cb1 initWithItem:@""];
    [payView addSubview:cb1];
    
    [payView.layer addSublayer:[self lineLayer:CGPointMake(0, 50)]];
    
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 50, ScreenWidth - 20, 50)];
    label2.text = @"支付方式";
    
    CheckButton *cb2 = [[CheckButton alloc]initWithFrame:CGRectMake(ScreenWidth - 220, 59, 100, 32)];
    [cb2 initWithItem:@"微信支付"];
    [cb2 addTarget:self action:@selector(paytypeClick:)];
    cb2.selected = YES;
    cb2.tag = 2;
    [payView addSubview:cb2];
    
    CheckButton *cb3 = [[CheckButton alloc]initWithFrame:CGRectMake(ScreenWidth - 110, 59, 100, 32)];
    [cb3 initWithItem:@"淘宝支付"];
    [cb3 addTarget:self action:@selector(paytypeClick:)];
    cb3.tag = 3;
    [payView addSubview:cb3];
    
    
    [payView.layer addSublayer:[self lineLayer:CGPointMake(0, 100)]];
    
    UILabel *label3 = [[UILabel alloc]initWithFrame:CGRectMake(10, 100, ScreenWidth - 20, 50)];
    label3.text = @"说点什么(必填)";
    
    UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(ScreenWidth / 2 - 10, 110, ScreenWidth / 2, 30)];
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.backgroundColor = [UIColor getHexColor:@"F8F8F8"];
    textField.tag = 4;
    [payView addSubview:textField];
    
    [payView.layer addSublayer:[self lineLayer:CGPointMake(0, 150)]];
    
    UILabel *label4 = [[UILabel alloc]initWithFrame:CGRectMake(10, 150, ScreenWidth - 20, 50)];
//    label4.text = @"应付￥7元";
    label4.tag = 15;
    
    QtyButton *qb = [[QtyButton alloc]initWithFrame:CGRectMake(ScreenWidth - 150, 153, 134, 44)];
    qb.style = 0;
    qb.tag = 5;
    [qb addTarget:self action:@selector(numChange:)];
    [payView addSubview:qb];
        
    
    UIButton *submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    submitButton.frame = CGRectMake(0, 200, ScreenWidth, 50);
    [submitButton setTitle:@"提交订单" forState:UIControlStateNormal];
    [submitButton setBackgroundColor:[UIColor getHexColor:@"F85C85"]];
    [submitButton setTitleShadowColor:[UIColor getHexColor:@"F7356A"] forState:UIControlStateNormal];
    
    [submitButton addTarget:self action:@selector(submitClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [payView addSubview:label1];
    [payView addSubview:label2];
    [payView addSubview:label3];
    [payView addSubview:label4];
    [payView addSubview:submitButton];
    
}

-(void)paytypeClick:(CheckButton *)obj{
    if (obj.tag == 2) {
        obj.selected = YES;
        CheckButton *cb = (CheckButton *)[self viewWithTag:3];
        cb.selected = NO;
    }else{
        obj.selected = YES;
        CheckButton *cb = (CheckButton *)[self viewWithTag:2];
        cb.selected = NO;
    }
}

-(void)numChange:(NSString *)str{
    QtyButton *qb = (QtyButton *)[self viewWithTag:5];
    UILabel *label = (UILabel *)[self viewWithTag:15];
    NSString *total = [NSString stringWithFormat:@"%0.2f",[_info floatForKey:@"price"] * [qb.qty integerValue]];
    //"应付￥元"
    label.attributedText = [self setColorText:[NSString stringWithFormat:@"应付￥%@元",total] range:NSMakeRange([@"应付￥" length], [total length])];
}


-(void)submitClick:(id)sender{
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:[_info strForKey:@"id"],@"id", nil];

    //是否匿名
    CheckButton *cb1 = (CheckButton *)[self viewWithTag:1];
    [dic setObject:[NSNumber numberWithBool:cb1.selected].stringValue forKey:@"is_show"];
    //支付方式
    CheckButton *cb23 = (CheckButton *)[self viewWithTag:2];
    NSString *paytype = cb23.selected ? @"4" : @"5";
    [dic setObject:paytype forKey:@"paytype"];
    //留言
    UITextField *textField = (UITextField *)[self viewWithTag:4];
    if ([textField.text length] == 0) return;
    [dic setObject:textField.text forKey:@"msg"];
    //数量
    QtyButton *qb = (QtyButton *)[self viewWithTag:5];
    [dic setObject:qb.qty forKey:@"qty"];
    
    if ([tar respondsToSelector:act]) {
        [tar performSelector:act withObject:dic];
    }
    
}

-(void)addTarget:(id)target action:(SEL)action{
    tar = target;
    act = action;
}

-(void)setInfo:(NSMutableDictionary *)info{
    _info = info;
    QtyButton *qb = (QtyButton *)[self viewWithTag:5];
    qb.maxValue = [[_info strForKey:@"maxValue"] integerValue];
    qb.minValue = [[_info strForKey:@"minValue"] integerValue];
    qb.qty = [_info strForKey:@"maxValue"];
    [self numChange:nil];
}



-(NSMutableAttributedString *)setColorText:(NSString *)str range:(NSRange)range{
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:str];
    [attrString addAttribute:NSForegroundColorAttributeName value:[UIColor getHexColor:@"ff6969"] range:range];
    return  attrString;
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
    [self endEditing:YES];
    [UIView animateWithDuration:.35 animations:^{
        backView.alpha = 0.0;
        payView.frame = CGRectMake(0, ScreenHeight, ScreenWidth, 250);
    } completion:^(BOOL finished) {
        self.hidden = YES;
    }];
    
//    [self removeFromSuperview];
}

-(void)dealloc{
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
