//
//  CouMyQtyCell.m
//  angelslike
//
//  Created by angelslike on 15/9/7.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import "CouMyQtyCell.h"

@implementation CouMyQtyCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)qtyChange:(NSString *)str{
//    NSString *amount = [NSString stringWithFormat:@"%0.2f",[self.info floatForKey:@"everyprice"] * [str floatValue]];
//    [self.info setObject:amount forKey:@"MyCouAmount"];
    [self.info setObject:str forKey:@"MyCouQty"];
    [self setQtyLabel:nil];
}

-(void)setQtyLabel:(NSString *)str{
    NSString *amount = [NSString stringWithFormat:@"￥%0.2f",[self.info floatForKey:@"everyprice"] * [self.info floatForKey:@"MyCouQty"]];
    [self.info setObject:amount forKey:@"MyCouAmount"];
    NSString *pre = @"合计 ";
    NSMutableString *nstr = [NSMutableString stringWithFormat:@"%@%@",pre,amount];
    label.attributedText = [self setColorText:nstr range:NSMakeRange([pre length], [amount length])];
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
        qb.style = 0;
        [self addSubview:qb];
        
        label = [[UILabel alloc]initWithFrame:RECT(10, 14, ScreenWidth - 20, 40)];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentRight;
        [self setQtyLabel:nil];
        [self addSubview:label];
        
        
    }
    return self;
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    [self setQtyLabel:nil];
}

-(void)setInfo:(NSMutableDictionary *)info{
    _info = info;
    qb.qty = [_info strForKey:@"MyCouQty"];
    [self setQtyLabel:nil];
//    [_info removeObserver:self forKeyPath:@"everyprice"];

    [_info addObserver:self forKeyPath:@"everyprice" options:NSKeyValueObservingOptionNew context:nil];
}

-(void)dealloc{
    [_info removeObserver:self forKeyPath:@"everyprice"];
}

@end
