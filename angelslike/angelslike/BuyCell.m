//
//  BuyCell.m
//  angelslike
//
//  Created by angelslike on 15/8/26.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import "BuyCell.h"

@implementation BuyCell

@synthesize info = _info;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initialSetting];
    }
    return self;
}

-(void)initialSetting{
    imageView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 80, 80)];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:imageView];
    
    nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(90, 5, ScreenWidth - 150 , 50)];
    nameLabel.backgroundColor = [UIColor clearColor];
    nameLabel.numberOfLines = 2;
    nameLabel.font = [UIFont boldSystemFontOfSize:14];
    [self addSubview:nameLabel];
    
    UIButton *redButton = [UIButton buttonWithType:UIButtonTypeCustom];
    redButton.frame = CGRectMake(90, 50, 30, 30);
    redButton.tag = 1;
    [redButton setTitle:@"-" forState:UIControlStateNormal];
    [redButton setTitleColor:[UIColor getHexColor:@"626262"] forState:UIControlStateNormal];
    [redButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self setButton:redButton withStyle:0];
    
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    addButton.frame = CGRectMake(150, 50, 30, 30);
    addButton.tag = 2;
    [addButton setTitle:@"+" forState:UIControlStateNormal];
    [addButton setTitleColor:[UIColor getHexColor:@"626262"] forState:UIControlStateNormal];
    [addButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self setButton:addButton withStyle:1];
    
    [self addSubview:redButton];
    [self addSubview:addButton];
    
    qty = [[UILabel alloc]initWithFrame:CGRectMake(120, 60, 30, 20)];
    qty.backgroundColor = [UIColor clearColor];
    qty.font = FontWS(14);
    qty.textAlignment = NSTextAlignmentCenter;
    qty.layer.borderColor = RGBA(178,177,182,.9).CGColor;
    qty.layer.borderWidth = 1.0;
    
    [self addSubview:qty];
    
    totalLabel = [[UILabel alloc]initWithFrame:CGRectMake(90, 30, ScreenWidth - 95, 30)];
    totalLabel.backgroundColor = [UIColor clearColor];
    totalLabel.textAlignment = NSTextAlignmentRight;
    totalLabel.textColor = [UIColor redColor];
    totalLabel.font = FontWS(12);
    [self addSubview:totalLabel];
    
    qtyLabel = [[UILabel alloc]initWithFrame:CGRectMake(90, 60, ScreenWidth - 95, 30)];
    qtyLabel.backgroundColor = [UIColor clearColor];
    qtyLabel.textAlignment = NSTextAlignmentRight;
    qtyLabel.textColor = [UIColor getHexColor:@"767676"];
    qtyLabel.font = FontWS(12);
    [self addSubview:qtyLabel];
}

-(void)buttonClick:(UIButton *)sender{
    if (sender.tag == 1) {
        if ([_info intForKey:@"qty"] != 1) {
            NSInteger nqty = [_info intForKey:@"qty"] - 1;
            [_info setObject:[NSString stringWithFormat:@"%ld",nqty] forKey:@"qty"];
            [self fillContent];
        }
    }else{
        NSInteger nqty = [_info intForKey:@"qty"] + 1;
        [_info setObject:[NSString stringWithFormat:@"%ld",nqty] forKey:@"qty"];
        [self fillContent];
    }
    
 
}

-(void)setButton:(UIButton *)button withStyle:(NSInteger)style{
/*
    UIRectCorner corner ;
    switch (style) {
        case 0:
            corner = UIRectCornerTopLeft | UIRectCornerBottomLeft;
            break;
        case 1:
            corner = UIRectCornerTopRight | UIRectCornerBottomRight;
            break;
        default:
            break;
    }


//    button.layer.borderWidth = 1.0;
//    button.layer.cornerRadius = 3.0;
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:button.bounds
                                                   byRoundingCorners:corner
                                                         cornerRadii:CGSizeMake(3.0, 3.0)];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame         = button.bounds;
    maskLayer.path          = maskPath.CGPath;
    button.layer.mask         = maskLayer;
 
 */
}

-(void)fillContent{
    [imageView setPreImageWithUrl:[_info strForKey:@"img"]];
    nameLabel.text = [_info strForKey:@"name"];
    qty.text = [_info strForKey:@"qty"];
    
    qtyLabel.text = [NSString stringWithFormat:@"x%@",[_info strForKey:@"qty"]];
    totalLabel.text = [NSString stringWithFormat:@"￥%0.2f",[_info floatForKey:@"qty"] * [_info floatForKey:@"price"]];
}

-(void)setInfo:(NSMutableDictionary *)info{
    _info = nil;
    _info = info;
    if (_info) {
        [self fillContent];
    }
    
}

@end
