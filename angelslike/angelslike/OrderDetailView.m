//
//  OrderDetailViewCell.m
//  angelslike
//
//  Created by angelslike on 15/9/10.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import "OrderDetailView.h"

@implementation OrderDetailView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        imageView = [[UIImageView alloc]initWithFrame:RECT(5, 5, 80, 60)];
        imageView.layer.cornerRadius = 5;
        imageView.layer.masksToBounds = YES;
        [self addSubview:imageView];
        
        name = [[UILabel alloc]initWithFrame:RECT(90, 5, ScreenWidth - 140, 30)];
        name.font = [UIFont boldSystemFontOfSize:11];
        [self addSubview:name];
        
        price = [[UILabel alloc]initWithFrame:RECT(5, 20, ScreenWidth - 10, 20)];
        price.font = FontWS(11);
        price.textAlignment = NSTextAlignmentRight;
        [self addSubview:price];
        
        total = [[UILabel alloc]initWithFrame:RECT(5, 40, ScreenWidth - 10, 20)];
        total.font = FontWS(11);
        total.textAlignment = NSTextAlignmentRight;
        [self addSubview:total];
        
        time = [[UILabel alloc]initWithFrame:RECT(5, 65, ScreenWidth - 10, 20)];
        time.font = FontWS(11);
        time.textColor = [UIColor lightGrayColor];
        [self addSubview:time];
        
        paytype = [[UILabel alloc]initWithFrame:RECT(5, 65, ScreenWidth - 10, 20)];
        paytype.font = FontWS(11);
        paytype.textColor = [UIColor lightGrayColor];
        paytype.textAlignment = NSTextAlignmentRight;
        [self addSubview:paytype];
    }
    
    return self;
}


-(void)setInfo:(NSDictionary *)info{
    _info = info;
    
    [imageView setPreImageWithUrl:[_info strForKey:@"img"]];
    name.text = [_info strForKey:@"name"];
    paytype.text  = [_info strForKey:@"paytype"];
    time.text = Format2(@"时间 ", [_info strForKey:@"time"]);
    
    price.text = Format3([_info strForKey:@"qty"], @" x ￥", [_info strForKey:@"price"]);
    total.text = Format2( @"合计 ￥", [_info strForKey:@"total"]);
}


@end
