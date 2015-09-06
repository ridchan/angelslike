//
//  MineView.m
//  angelslike
//
//  Created by angelslike on 15/9/1.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import "MineView.h"

@implementation MineView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.clipsToBounds = YES;
        self.backgroundColor = [UIColor getHexColor:@"FFD34C"];
        [self initialSetting];
    }
    return self;
}

-(void)initialSetting{
    
    contentView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    contentView.backgroundColor = [UIColor clearColor];
    contentView.alpha = .0;
    [contentView addSubview:[self labelName:@"姓名" frame:CGRectMake(10, 20, 100, 30)]];
    [contentView addSubview:[self labelName:@"地址" frame:CGRectMake(10, 60, 100, 30)]];
    [contentView addSubview:[self labelName:@"详细地址" frame:CGRectMake(10, 100, 100, 30)]];
    [contentView addSubview:[self labelName:@"电话" frame:CGRectMake(10, 140, 100, 30)]];
    
    [contentView addSubview:[self textField:CGRectMake(self.frame.size.width / 3, 20, self.frame.size.width / 3 * 2 - 10, 30)]];
    [contentView addSubview:[self textField:CGRectMake(self.frame.size.width / 3, 60, self.frame.size.width / 3 * 2 - 10, 30)]];
    [contentView addSubview:[self textField:CGRectMake(self.frame.size.width / 3, 100, self.frame.size.width / 3 * 2 - 10, 30)]];
    [contentView addSubview:[self textField:CGRectMake(self.frame.size.width / 3, 140, self.frame.size.width / 3 * 2 - 10, 30)]];
    
    
    RCRoundButton *button = [RCRoundButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(10, 190, self.frame.size.width - 20, 45);
    [button setCorner:8.0];
    button.titleLabel.font = FontWS(18);
    button.backgroundColor = [UIColor getHexColor:@"ff6600"];
    [button setTitle:@"确认" forState:UIControlStateNormal];
    [contentView addSubview:button];
    
    [self addSubview:contentView];
    
    CGFloat height = self.frame.size.width * 286 / 383;
    imageView =[[UIImageView alloc]initWithFrame:CGRectMake(0, self.frame.size.height - height + 30, self.frame.size.width,  height )];
    imageView.contentMode =  UIViewContentModeScaleAspectFit;
    imageView.image = [UIImage imageNamed:@"sendmy"];
    [self addSubview:imageView];

}

-(UITextField *)textField:(CGRect)frame{
    UITextField *txt = [[UITextField alloc]initWithFrame:frame];
    txt.font = FontWS(14);
    txt.backgroundColor = [UIColor getHexColor:@"F8F8F8"];
    txt.borderStyle = UITextBorderStyleNone;
    txt.layer.borderColor = [UIColor getHexColor:@"bbbbbb"].CGColor;
    txt.layer.borderWidth = 1.0;
    txt.layer.cornerRadius = 4;
    txt.layer.masksToBounds = YES;
    return txt;
}

-(UILabel *)labelName:(NSString *)name frame:(CGRect)frame{
    UILabel *label1 = [[UILabel alloc]initWithFrame:frame];
    label1.backgroundColor = [UIColor clearColor];
    label1.text = name;
    return label1;
}

-(void)showContent{
    [UIView animateWithDuration:0.35 animations:^{
        contentView.alpha =  1.0;
        if (isiPhone4) {
            imageView.center = CGPointMake(imageView.center.x, imageView.center.y - imageView.frame.size.height);
            imageView.alpha = 0.0;
        }
    }];
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
                imageView.center = CGPointMake(imageView.center.x, imageView.center.y - imageView.frame.size.height);
                imageView.alpha = 0.0;
            }
        } completion:^(BOOL finished) {
            
        }];
    }
}

-(void)dismiss{
    [UIView animateWithDuration:0.35 animations:^{
        if (isiPhone4) {
            CGFloat height = self.frame.size.width * 286 / 383;
            imageView.frame = CGRectMake(0, self.frame.size.height - height + 30, self.frame.size.width,  height );
            imageView.alpha = 1.0;
        }
        contentView.alpha = 0.0;
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
