//
//  ItemCell.m
//  angelslike
//
//  Created by angelslike on 15/8/27.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import "ItemCell.h"

@implementation ItemCell

@synthesize info = _info;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //
        nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, ScreenWidth - 10, 30)];
        nameLabel.font = [UIFont boldSystemFontOfSize:19];
        
        contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, nameLabel.frame.size.height + 10, ScreenWidth - 20, 50)];
        contentLabel.textColor = [UIColor getHexColor:@"767676"];
        contentLabel.font = FontWS(13);
        contentLabel.numberOfLines = 0;
        
        imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, contentLabel.frame.origin.y + contentLabel.frame.size.height + 10, ScreenWidth - 20, (ScreenWidth - 10) * 9 / 16)];
        
        priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, imageView.frame.origin.y + imageView.frame.size.height, ScreenWidth - 20, 40)];
        priceLabel.textColor = [UIColor getHexColor:@"F44236"];
        
        
        UIColor *color = [UIColor getHexColor:@"F34336"];
        
        viewButton  =  [RCRoundButton buttonWithType:UIButtonTypeCustom];
        viewButton.radio = 15;
        viewButton.frame = CGRectMake(ScreenWidth - 100, 250, 80, 30);
        
        viewButton.layer.borderColor = color.CGColor;
        viewButton.titleLabel.font = FontWS(12);
        [viewButton setTitleColor:color forState:UIControlStateNormal];
        [viewButton setTitle:@"查看详情" forState:UIControlStateNormal];
        [viewButton addTarget:self action:@selector(viewButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:viewButton];
        
        [self addSubview:nameLabel];
        [self addSubview:contentLabel];
        [self addSubview:imageView];
        [self addSubview:priceLabel];
        line = [self lineLayer:CGPointMake(0, 0)];
        [self.layer addSublayer:line];
    }
    
    return self;
}

-(void)viewButtonClick:(id)sender{
    if ([_delegate respondsToSelector:@selector(checkButtonClick:)]) {
        [_delegate performSelector:@selector(checkButtonClick:) withObject:self.info];
    }
}

-(CAShapeLayer *)lineLayer:(CGPoint)position{
    CAShapeLayer *layer = [CAShapeLayer new];
    UIBezierPath *path = [UIBezierPath new];
    [path moveToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(ScreenWidth, 0)];
    
    
    layer.path = path.CGPath;
    layer.lineWidth = 0.5;
    layer.strokeColor = RGBA(178,177,182,.9).CGColor;
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.position = position;
    return layer;
}

-(NSString *)removeHtml:(NSString *)str{
    NSRegularExpression *regular = [NSRegularExpression regularExpressionWithPattern:@"<p></p><br/>" options:NSRegularExpressionCaseInsensitive error:nil];
    return [regular stringByReplacingMatchesInString:str options:NSMatchingReportProgress range:NSMakeRange(0, [str length]) withTemplate:@""];
//    return [[str stringByReplacingOccurrencesOfString:@"<p>" withString:@""] stringByReplacingOccurrencesOfString:@"</p>" withString:@""];
}

-(void)setInfo:(NSDictionary *)info{
    _info = info;
    if (_info) {
        nameLabel.text = [_info strForKey:@"name"];
        [contentLabel setTextResize:[self removeHtml:[_info strForKey:@"content"]]];
        
        imageView.frame = CGRectMake(10, contentLabel.frame.origin.y + contentLabel.frame.size.height + 10, imageView.frame.size.width, imageView.frame.size.height);
        
        [imageView setPreImageWithUrl:[_info strForKey:@"img"]];
        
        
        priceLabel.frame = CGRectMake(10, imageView.frame.origin.y + imageView.frame.size.height +10, priceLabel.frame.size.width, priceLabel.frame.size.height);
        priceLabel.text = [NSString stringWithFormat:@"￥%@",[_info strForKey:@"price"]];
        
        viewButton.center = CGPointMake(viewButton.center.x, priceLabel.center.y);
        
        self.frame = CGRectMake(0, 0, ScreenWidth, priceLabel.frame.origin.y + priceLabel.frame.size.height + 10);
        
        line.position = CGPointMake(0, self.frame.size.height - 1);
    }
}

@end
