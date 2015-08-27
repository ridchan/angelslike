//
//  CouDetailCell.m
//  angelslike
//
//  Created by angelslike on 15/8/13.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import "CouDetailCell.h"

@implementation CouDetailCell

@synthesize info = _info;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        if (!imageView) {
            imageView =  [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 60, 60)];
            imageView.layer.cornerRadius = 25.0;
            imageView.layer.masksToBounds = YES;
            imageView.contentMode = UIViewContentModeScaleAspectFit;
            [self addSubview:imageView];
        }

        if (!nameLabel) {
            nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(70, 5, 100, 30)];
            nameLabel.font = FontWS(10);
            nameLabel.backgroundColor = [UIColor clearColor];
            [self addSubview:nameLabel];
        }
        
        if (!timeStartLabel) {
            timeStartLabel = [[UILabel alloc]initWithFrame:CGRectMake(70, 35, 100, 20)];
            timeStartLabel.font = FontWS(9);
            timeStartLabel.backgroundColor = [UIColor clearColor];
            [self addSubview:timeStartLabel];
        }
        
        if (!timeEndLabel) {
            timeEndLabel = [[UILabel alloc]initWithFrame:CGRectMake(70, 55, 100, 20)];
            timeEndLabel.font = FontWS(9);
            timeEndLabel.backgroundColor = [UIColor clearColor];
            [self addSubview:timeEndLabel];
        }

        

        if (!statuLabel) {
            statuLabel = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth - 60 - CouCellMargin * 2, 80, 50, 22)];
            statuLabel.backgroundColor = [UIColor clearColor];
            statuLabel.font = FontWS(10);
            statuLabel.textAlignment = NSTextAlignmentCenter;
            statuLabel.textColor = [UIColor getHexColor:@"F88F19"];
            statuLabel.layer.borderWidth = 1;
            statuLabel.layer.masksToBounds = YES;
            statuLabel.layer.cornerRadius = 3;
            statuLabel.layer.borderColor = statuLabel.textColor.CGColor;
            [self addSubview:statuLabel];
        }

        CALayer *line1 = [self lineLayer:CGPointMake(0, 100)];
        [self.layer addSublayer:line1];
        
        
        
        targetLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 100, ScreenWidth / 3, 30)];
        targetLabel.font = FontWS(10);
        targetLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:targetLabel];
        
        priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth / 3, 100, ScreenWidth / 3, 30)];
        priceLabel.backgroundColor = [UIColor clearColor];
        priceLabel.font = FontWS(10);
        [self addSubview:priceLabel];
        
        totalLabel = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth / 3 * 2, 100, ScreenWidth / 3, 30)];
        totalLabel.backgroundColor = [UIColor clearColor];
        totalLabel.font = FontWS(10);
        [self addSubview:totalLabel];
        
        CALayer *line2 = [self lineLayer:CGPointMake(0, 130)];
        [self.layer addSublayer:line2];
    
    }
    return self;
}

-(NSMutableAttributedString *)setColorText:(NSString *)str range:(NSRange)range{
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:str];

    
    [attrString addAttribute:NSForegroundColorAttributeName value:[UIColor getHexColor:@"FA9E47"] range:range];
//    [attrString addAttribute:NSFontAttributeName value:FontWS(dayLabel.font.pointSize + 3) range:range];
    return  attrString;
}

-(CAShapeLayer *)lineLayer:(CGPoint)position{
    CAShapeLayer *layer = [CAShapeLayer new];
    UIBezierPath *path = [UIBezierPath new];
    [path moveToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(ScreenWidth, 0)];
    
    
    layer.path = path.CGPath;
    layer.lineWidth = 1.0;
    layer.strokeColor = RGBA(178,177,182,.9).CGColor;
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.position = position;
    return layer;
}

-(void)setInfo:(NSDictionary *)info{
    _info = [info mutableCopy];
    [imageView setPreImageWithUrl:[_info strForKey:@"pimg"]];
    nameLabel.text = [_info strForKey:@"uname"];
    timeStartLabel.text = [NSString stringWithFormat:@"开始时间:%@",[_info strForKey:@"starttime"]];
    timeEndLabel.text = [NSString stringWithFormat:@"结束时间:%@",[_info strForKey:@"endtime"]];
    statuLabel.text = [_info strForKey:@"nowstatus"];
    
    NSString *str1 = [NSString stringWithFormat:@"目标"];
    NSString *str2 = [NSString stringWithFormat:@"￥%0.2f元",[_info floatForKey:@"price"]];
    targetLabel.attributedText = [self setColorText:[NSString stringWithFormat:@"%@%@",str1,str2] range:NSMakeRange([str1 length] - 1, [str2 length])];
    
    str1 = [NSString stringWithFormat:@"每份"];
    str2 = [NSString stringWithFormat:@"￥%0.2f元",[_info floatForKey:@"price"] / [_info floatForKey:@"copies"]];
    priceLabel.attributedText = [self setColorText:[NSString stringWithFormat:@"%@%@",str1,str2] range:NSMakeRange([str1 length] - 1, [str2 length])];
    
    str1 = [NSString stringWithFormat:@"共"];
    str2 = [NSString stringWithFormat:@"￥%@份",[_info strForKey:@"copies"]];
    totalLabel.attributedText = [self setColorText:[NSString stringWithFormat:@"%@%@",str1,str2] range:NSMakeRange([str1 length] - 1, [str2 length])];
    
    
}

@end
