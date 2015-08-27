//
//  ProductCell.m
//  angelslike
//
//  Created by angelslike on 15/8/19.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import "ProductCell.h"

@implementation ProductCell

@synthesize info = _info;

-(instancetype)init{
    if (self = [super init]) {
        //
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //
        imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 100)];
        [self.contentView addSubview:imageView];
        
        nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 100, self.frame.size.width - 10, 25)];
        nameLabel.font = FontWS(12);
        [self.contentView addSubview:nameLabel];
        
        priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 125, self.frame.size.width - 10, 25)];
        priceLabel.font = FontWS(11);
        priceLabel.textColor = [UIColor redColor];
        [self.contentView addSubview:priceLabel];
        
        self.contentView.layer.borderColor = RGBA(178,177,182,.9).CGColor;
        self.contentView.layer.borderWidth = 0.5;
    }
    return self;
}


-(void)setInfo:(NSDictionary *)info{
    _info = info;
    if (_info) {
        [imageView setPreImageWithUrl:[_info strForKey:@"img"]];
        nameLabel.text = [_info strForKey:@"name"];
        priceLabel.text = [NSString stringWithFormat:@"￥%0.2f",[_info floatForKey:@"price"]];
    }
}



@end
