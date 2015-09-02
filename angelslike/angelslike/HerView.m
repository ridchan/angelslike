//
//  HerView.m
//  angelslike
//
//  Created by angelslike on 15/9/1.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import "HerView.h"

@implementation HerView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.clipsToBounds = YES;
        self.backgroundColor = [UIColor getHexColor:@"FFE9A5"];
        [self initialSetting];
    }
    
    return self;
}

-(void)initialSetting{
    
    
    
    contentView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    contentView.backgroundColor = [UIColor clearColor];
    contentView.alpha = 0.0;
    
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, contentView.frame.size.height - 285, contentView.frame.size.width - 20, 30)];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = HexColor(@"CC3300");
    label.font = FontWS(15);
    label.text = @"收礼物填写收货信息";
    [contentView addSubview:label];
    
    [contentView addSubview:[self textField:CGRectMake(10, contentView.frame.size.height - 245, contentView.frame.size.width - 20, 80)]];

    RCRoundButton *button = [RCRoundButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(10, contentView.frame.size.height - 45 - 90, self.frame.size.width - 20, 45);
    [button setCorner:8.0];
    button.titleLabel.font = FontWS(18);
    [button setTitleShadowColor:[UIColor getHexColor:@"ffdd66"] forState:UIControlStateNormal];
    button.backgroundColor = [UIColor getHexColor:@"ff6600"];
    [button setTitle:@"发送给收礼人" forState:UIControlStateNormal];
    [contentView addSubview:button];
    
    [self addSubview:contentView];
    
    imageView =[[UIImageView alloc]initWithFrame:CGRectMake(0, 40, self.frame.size.width, self.frame.size.height / 2 - 40)];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.image = [UIImage imageNamed:@"sendta"];
    [self addSubview:imageView];
}

-(UITextView *)textField:(CGRect)frame{
    UITextView *txt = [[UITextView alloc]initWithFrame:frame];
    txt.font = FontWS(14);
    txt.backgroundColor = [UIColor getHexColor:@"F8F8F8"];
    txt.layer.borderColor = [UIColor getHexColor:@"bbbbbb"].CGColor;
    txt.layer.borderWidth = 1.0;
    txt.layer.cornerRadius = 4;
    txt.layer.masksToBounds = YES;
    return txt;
}

-(void)show{
    bShow = NO;
    if (bShow){
        bShow = NO;
        [self dismiss];
    }else{
        bShow = YES;
        [UIView animateKeyframesWithDuration:0.35 delay:0.4 options:UIViewKeyframeAnimationOptionAllowUserInteraction animations:^{
            contentView.alpha = 1.0;
            if (isiPhone4) {
                imageView.center = CGPointMake(imageView.center.x, imageView.center.y + imageView.frame.size.height);
                imageView.alpha = 0.0;
            }
        } completion:^(BOOL finished) {
            
        }];
    }
}

-(void)dismiss{
    [UIView animateWithDuration:0.35 animations:^{
        if (isiPhone4) {
            imageView.frame = CGRectMake(0, 40, self.frame.size.width, self.frame.size.height / 2 - 40);
            imageView.alpha = 1.0;
        }
        contentView.alpha = 0.0;
    }];
}

@end
