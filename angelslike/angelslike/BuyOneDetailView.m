//
//  BuyOneDetailView.m
//  angelslike
//
//  Created by angelslike on 15/10/9.
//  Copyright © 2015年 angelslike. All rights reserved.
//

#import "BuyOneDetailView.h"

@implementation BuyOneDetailView


-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, frame.size.width - 20, 200)];
        //        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:imageView];
        
        nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 215, frame.size.width - 20, 30)];
        nameLabel.backgroundColor = [UIColor clearColor];
        nameLabel.font = FontWS(18);
        [self addSubview:nameLabel];
        
        priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(10 , 250, frame.size.width - 20, 30)];
        priceLabel.backgroundColor = [UIColor clearColor];
        priceLabel.textColor = [UIColor getHexColor:@"F44236"];
        priceLabel.font = FontWS(20);
        [self addSubview:priceLabel];
        
        stockLabel = [[UILabel alloc]initWithFrame:RECT(10, MaxY(priceLabel), frame.size.width - 20, 30)];
        stockLabel.backgroundColor = [UIColor clearColor];
        stockLabel.font = FontWS(14);
        [self addSubview:stockLabel];
        
        UIColor *color = [UIColor getHexColor:@"F34336"];
        RCRoundButton *viewButton  =  [RCRoundButton buttonWithType:UIButtonTypeCustom];
        viewButton.radio = 20;
        viewButton.frame = CGRectMake(frame.size.width - 112, 245, 102, 40);
        
        viewButton.layer.borderColor = color.CGColor;
        viewButton.titleLabel.font = FontWS(15);
        [viewButton setTitleColor:color forState:UIControlStateNormal];
        [viewButton setTitle:@"查看详情" forState:UIControlStateNormal];
        [viewButton addTarget:self action:@selector(viewButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:viewButton];
        
        contentLabel = [[RCWebView alloc]initWithFrame:CGRectMake(0, 320, frame.size.width, 1)];
        contentLabel.backgroundColor = [UIColor clearColor];
        contentLabel.scrollView.scrollEnabled = NO;
        [self addSubview:contentLabel];
        
    }
    return self;
}

-(void)viewButtonClick:(id)sender{
    if ([_delegate respondsToSelector:@selector(checkButtonClick:)]) {
        [_delegate performSelector:@selector(checkButtonClick:) withObject:sender];
    }
}

-(void)setInfo:(NSDictionary *)info{
    _info = info;
    
    __block BuyOneDetailView *tempSelf = self;
    
    [imageView setPreImageWithUrl:[_info strForKey:@"img"]];
    nameLabel.text = [_info strForKey:@"productname"];
    priceLabel.text = [NSString stringWithFormat:@"￥%@/两件",[_info strForKey:@"price"]];
    stockLabel.text = [NSString stringWithFormat:@"限量: %@   剩余: %d",[_info strForKey:@"qtylimit"],(int)([_info intForKey:@"qtylimit"] - [_info intForKey:@"salesqty"])];
    
    [contentLabel setText:[_info strForKey:@"sharetext"]];
    contentLabel.block = ^(id obj){
        tempSelf.frame = RECT(tempSelf.frame.origin.x, tempSelf.frame.origin.y, tempSelf.frame.size.width, [obj floatValue]);
        if (tempSelf.block) tempSelf.block([NSString stringWithFormat:@"%f",MaxY(tempSelf)]);
    };
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
