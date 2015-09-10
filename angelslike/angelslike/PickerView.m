//
//  PickerView.m
//  angelslike
//
//  Created by angelslike on 15/9/9.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import "PickerView.h"

@implementation PickerView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor =  [UIColor clearColor];
        
        label = [[UILabel alloc]initWithFrame:RECT(0, 0, frame.size.width  , frame.size.height)];
        
        label.layer.borderColor = [UIColor lightGrayColor].CGColor;
        label.layer.borderWidth = 1.0;
        label.layer.masksToBounds = YES;
        label.layer.cornerRadius = 5;
//        label.textAlignment = NSTextAlignmentCenter;
        label.font = FontWS(12);
        
        label.textColor = [UIColor blackColor];
        
        [self.layer addSublayer:[self shadowAsInverse]];
        [self addSubview:label];
        
        layer = [CALayer layer];
        layer.frame = RECT(frame.size.width - 15, frame.size.height / 2 - 5, 10, 10);
        layer.contents = (id)IMAGE(@"arrow").CGImage;
        [self.layer addSublayer:layer];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
        [self addGestureRecognizer:tap];
        
    }
    return self;
}

-(void)tap:(id)obj{
    self.selected = !self.selected;
    if ([tar respondsToSelector:act]) {
        [tar performSelector:act withObject:self];
    }
}

- (CAGradientLayer *)shadowAsInverse
{
    CAGradientLayer *newShadow = [[CAGradientLayer alloc] init] ;
    CGRect newShadowFrame = label.frame;
    newShadow.frame = newShadowFrame;
    newShadow.cornerRadius = 5;
    newShadow.masksToBounds = YES;
    //添加渐变的颜色组合
    newShadow.colors = [NSArray arrayWithObjects:(id)HexColor(@"ffffff").CGColor,(id)HexColor(@"e5e5e5").CGColor,nil];
    return newShadow;
}

-(void)setText:(NSString *)text{
    _text = text;
    label.text = Format2(@"  ", text) ;
}

-(void)setSelected:(BOOL)selected{
    _selected = selected;

//    label.layer.borderColor = _selected?[UIColor blueColor].CGColor:[UIColor lightGrayColor].CGColor;
    
}


-(void)addTarget:(id)target action:(SEL)action{
    tar = target;
    act = action;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
