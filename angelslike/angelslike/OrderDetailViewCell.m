//
//  OrderDetailViewCell.m
//  angelslike
//
//  Created by angelslike on 15/9/10.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import "OrderDetailViewCell.h"

@implementation OrderDetailViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        imageView = [[UIImageView alloc]initWithFrame:RECT(5, 5, 80, 60)];
        [self addSubview:imageView];
        
        name = [[UILabel alloc]initWithFrame:RECT(90, 5, ScreenWidth - 160, 30)];
        name.font = [UIFont boldSystemFontOfSize:14];
        [self addSubview:name];
        
        time = [[UILabel alloc]initWithFrame:RECT(5, 90, ScreenWidth - 10, 20)];
        time.font = FontWS(11);
        [self addSubview:time];
        
        paytype = [[UILabel alloc]initWithFrame:RECT(5, 90, ScreenWidth - 10, 20)];
        paytype.font = FontWS(11);
        [self addSubview:paytype];
        
    }
    return self;
}


-(void)setInfo:(NSDictionary *)info{
    _info = info;
    
    [imageView setPreImageWithUrl:[_info strForKey:@"img"]];
    name.text = [_info strForKey:@"name"];
    
}


@end
