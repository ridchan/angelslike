//
//  CouNameCell.m
//  angelslike
//
//  Created by angelslike on 15/9/7.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import "CouNameCell.h"

@implementation CouNameCell
@synthesize info = _info;


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        imageView = [[UIImageView alloc]initWithFrame:RECT(10, 10, 110, 80)];
        [self addSubview:imageView];
        
        name = [[UILabel alloc]initWithFrame:RECT(130, 10, ScreenWidth - 140, 40)];
        name.numberOfLines = 2;
        name.backgroundColor = [UIColor clearColor];
        name.font = FontWS(16);
        name.textColor = HexColor(@"666666");
        [self addSubview:name];
        
        price = [[UILabel alloc]initWithFrame:RECT(130, 50, ScreenWidth - 140, 30)];
        price.numberOfLines = 2;
        price.backgroundColor = [UIColor clearColor];
        price.font = FontWS(19);
        price.textColor = HexColor(@"F44236");
        [self addSubview:price];
    }
    return self;
}

-(void)setInfo:(NSMutableDictionary *)info{
    _info = info;
    [imageView setPreImageWithUrl:[_info strForKey:@"img"]];
    name.text = [_info strForKey:@"name"];
    price.text = [NSString stringWithFormat:@"￥%@",[_info strForKey:@"price"]];
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
