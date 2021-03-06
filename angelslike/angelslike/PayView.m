//
//  PayView.m
//  angelslike
//
//  Created by angelslike on 15/9/28.
//  Copyright © 2015年 angelslike. All rights reserved.
//

#import "PayView.h"

@implementation PayView

@synthesize selectIndex = _selectIndex;

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        _selectIndex = 0;
        [self initialSetting];
    }
    return self;
}


-(void)buttonClick:(UIButton *)sender{
    UIImageView *imageView = (UIImageView *)[self viewWithTag:11];
    UIImageView *imageView2 = (UIImageView *)[self viewWithTag:12];
    if (sender.tag == 1) {
        imageView.image = [UIImage imageNamed:@"pieceorder_check_press"];
        imageView2.image = [UIImage imageNamed:@"pieceorder_check_def"];
    }else{
        imageView2.image = [UIImage imageNamed:@"pieceorder_check_press"];
        imageView.image = [UIImage imageNamed:@"pieceorder_check_def"];
    }
    _selectIndex = sender.tag - 1;
    
    [self.info setObject:[NSString stringWithFormat:@"%d",(int)(_selectIndex + 4)] forKey:@"paytype"];
}

-(void)setSelectIndex:(NSInteger)selectIndex{
    _selectIndex = selectIndex;
    UIButton *b = [UIButton buttonWithType:UIButtonTypeCustom];
    b.tag = _selectIndex + 1;
    [self buttonClick:b];
    
}



-(void)initialSetting{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 6, 32, 32)];
    imageView.tag = 11;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(44, 6, ScreenWidth / 2 - 44, 32)];
    label.backgroundColor = [UIColor clearColor];
    label.text = @"微信支付";
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, ScreenWidth / 2, 44);
    button.tag = 1;
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIImageView *imageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(10 + ScreenWidth / 2, 6, 32, 32)];
    imageView2.tag = 12;
    
    
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(44 + ScreenWidth / 2, 6, ScreenWidth / 2 - 44, 32)];
    label2.backgroundColor = [UIColor clearColor];
    label2.text = @"支付宝支付";
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(ScreenWidth / 2, 0, ScreenWidth / 2, 44);
    button2.tag = 2;
    [button2 addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:button];
    [self addSubview:button2];
    
    [self addSubview:imageView];
    [self addSubview:label];
    
    [self addSubview:imageView2];
    [self addSubview:label2];
    
}

@end
