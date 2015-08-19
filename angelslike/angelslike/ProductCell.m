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
        NSLog(@"init collection cell");
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //
        imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 100)];
        [self.contentView addSubview:imageView];
        
        nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 100, self.frame.size.width, 25)];
        [self.contentView addSubview:nameLabel];
        
        priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 125, self.frame.size.width, 25)];
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
        
    }
    
    [imageView sd_setImageWithURL:[NSURL URLWithString:@"http://img1.angelslike.com/303514b47427b705fcfa1891975d0eac.jpeg"]];
    nameLabel.text = @"卡通充电宝";
    priceLabel.text = @"￥79.00";
}



@end
