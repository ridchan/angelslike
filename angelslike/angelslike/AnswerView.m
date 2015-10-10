//
//  AnswerView.m
//  angelslike
//
//  Created by angelslike on 15/9/10.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import "AnswerView.h"
#define ViewWidth 260

@implementation AnswerView


-(void)dealloc{
    self.block = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(instancetype)init{
    if (self = [super initWithFrame:RECT(0, 0, ScreenWidth, ScreenHeight)]) {
        self.backgroundColor = [UIColor clearColor];
        anView = [[UIView alloc]init];
        anView.frame = RECT(0, 0, ViewWidth, 200);
        anView.center =  CGPointMake(ScreenWidth / 2, ScreenHeight / 2);
        anView.backgroundColor = HexColor(@"e8e8e8");
        anView.layer.masksToBounds = YES;
        anView.layer.cornerRadius = 5;

        [self addSubview:anView];
        

        title = [[UILabel alloc]initWithFrame:RECT(0, 0, ViewWidth, 50)];
        title.backgroundColor = [UIColor clearColor];
        title.textColor = [UIColor blackColor];
        title.textAlignment = NSTextAlignmentCenter;
        [anView addSubview:title];
        

        textView = [[UITextView alloc]initWithFrame:RECT(10, 60, ViewWidth - 20, 80)];
        textView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        textView.layer.borderWidth = 1.0;
        textView.layer.cornerRadius = 3.0;
        textView.layer.masksToBounds = YES;
        [anView addSubview:textView];
        
        
        [anView addSubview:[self lineWithFrame:RECT(0, 160, ViewWidth, 1)]];
        
        cancelButton = [self buttonWithFrame:RECT(0, 160, ViewWidth / 2, 40) title:@"返回"];
        cancelButton.tag = AnswerViewType_Cancel;
        [anView addSubview:cancelButton];
        
        [anView addSubview:[self lineWithFrame:RECT(ViewWidth/2, 160, 1, 40)]];
        
        comfirmButton = [self buttonWithFrame:RECT(ViewWidth / 2, 160, ViewWidth / 2, 40) title:@"确定"];
        comfirmButton.tag = AnswerViewType_Comfrim;
        [anView addSubview:comfirmButton];
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
    }
    
    return self;
}

-(void)keyboardShow:(id)obj{
    [UIView animateWithDuration:0.35 animations:^{
        anView.center = CGPointMake(ScreenWidth / 2, ScreenHeight / 4);
    }];
}

-(void)keyboardHide:(id)obj{
    [UIView animateWithDuration:0.35 animations:^{
        anView.center = CGPointMake(ScreenWidth / 2, ScreenHeight / 2);
    }];
    
}

-(UIButton *)buttonWithFrame:(CGRect)rect title:(NSString *)strTitle{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = rect;
    [button setTitle:strTitle forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self dismiss];
}

-(UIView *)lineWithFrame:(CGRect)frame{
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.backgroundColor = [UIColor lightGrayColor];
    return view;
}

-(void)buttonClick:(UIButton *)obj{
    [self dismiss];
    __block UIButton *tempButton = obj;
    if (_block) {
        NSDictionary *dic = @{@"object":object,@"content":textView.text};
        _block(dic,(AnswerViewType)tempButton.tag);
    }
}

-(void)showWithObject:(id)obj withTitle:(NSString *)msg{
    title.text = msg;
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    object = obj;
    [window addSubview:self];
    [self show];
}

-(void)show{
    self.hidden = NO;
    anView.transform =  CGAffineTransformMakeScale(0.6, 0.6);
    [UIView animateWithDuration:0.35 animations:^{
        self.backgroundColor = RGBA(0, 0, 0, 0.4);
        anView.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:^(BOOL finished) {
        
    }];
}

-(void)dismiss{
    self.hidden = YES;
    [self removeFromSuperview];
//    self.backgroundColor = [UIColor clearColor];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
