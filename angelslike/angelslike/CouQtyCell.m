//
//  CouQtyCell.m
//  angelslike
//
//  Created by angelslike on 15/9/7.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import "CouQtyCell.h"

@implementation CouQtyCell

@synthesize info = _info;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)qtyChange:(NSString *)str{
    self.everyPrice = [NSString stringWithFormat:@"%0.2f",[_info floatForKey:@"price"] / [str floatValue]];
    [self.info setObject:str forKey:@"qty"];
    [self.info setObject:self.everyPrice forKey:@"everyprice"];
    [self setQtyLabel];
}

-(void)setQtyLabel{
    NSString *price =[NSString stringWithFormat:@"￥%@",[self.info strForKey:@"everyprice"]];
    NSString *fix = @"/份";
    NSMutableString *nstr = [NSMutableString stringWithFormat:@"%@%@",price,fix];
    label.attributedText = [self setColorText:nstr range:NSMakeRange(0, [price length])];
}

-(NSMutableAttributedString *)setColorText:(NSString *)str range:(NSRange)range{
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:str];
    [attrString addAttribute:NSForegroundColorAttributeName value:[UIColor getHexColor:@"ff6969"] range:range];
    return  attrString;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //
        qb = [[QtyButton alloc]initWithFrame:RECT(10, 14, 130, 40)];
        [qb addTarget:self action:@selector(qtyChange:)];
        qb.qty = @"2";
        qb.minValue = 2;
        qb.style = 0;
        [self addSubview:qb];
        
        label = [[UILabel alloc]initWithFrame:RECT(10, 14, ScreenWidth - 20, 40)];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentRight;
        label.font = FontWS(19);
        
        [self setQtyLabel];
        [self addSubview:label];
        
    }
    return self;
}

-(void)setInfo:(NSMutableDictionary *)info{
    _info = info;
    qb.qty = [_info strForKey:@"qty"];
    [self setQtyLabel];
}

@end
