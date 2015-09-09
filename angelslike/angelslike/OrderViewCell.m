//
//  OrderViewCell.m
//  angelslike
//
//  Created by angelslike on 15/9/9.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import "OrderViewCell.h"

@implementation OrderViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        order = [[UILabel alloc]initWithFrame:RECT(5, 5, ScreenWidth - 10, 20)];
        order.font = FontWS(11);
        [self addSubview:order];
        
        statu = [[UILabel alloc]initWithFrame:RECT(5, 5, ScreenWidth - 10, 20)];
        statu.textAlignment = NSTextAlignmentRight;
        [self addSubview:statu];
    }
    return self;
}

@end
