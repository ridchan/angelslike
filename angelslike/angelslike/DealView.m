//
//  DealView.m
//  angelslike
//
//  Created by angelslike on 15/9/24.
//  Copyright © 2015年 angelslike. All rights reserved.
//

#import "DealView.h"

@implementation DealView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //
        self.backgroundColor = [UIColor whiteColor];
        imageView = [[UIImageView alloc]initWithFrame:RECT(0, 0, self.frame.size.width, self.frame.size.height * 2 / 3)];
        [self addSubview:imageView];
        
        nameLbl = [[UILabel alloc]initWithFrame:RECT(5, CGRectGetMaxY(imageView.frame), self.frame.size.width - 10, 20)];
        nameLbl.backgroundColor = [UIColor clearColor];
        nameLbl.font = FontWS(13);
        [self addSubview:nameLbl];
        
        priceLbl = [[UILabel alloc]initWithFrame:RECT(5, CGRectGetMaxY(nameLbl.frame), self.frame.size.width - 10, 20)];
        priceLbl.backgroundColor = [UIColor clearColor];
        priceLbl.textColor = HexColor(@"6A6A6A");
        priceLbl.font = FontWS(12);
        [self addSubview:priceLbl];
        
        lbl2 = [[UILabel alloc]initWithFrame:RECT(5, CGRectGetMaxY(nameLbl.frame), self.frame.size.width - 10, 20)];
        lbl2.backgroundColor = [UIColor clearColor];
        lbl2.textAlignment = NSTextAlignmentRight;
        lbl2.textColor = HexColor(@"6A6A6A");
        lbl2.font = FontWS(12);
        [self addSubview:lbl2];
        
        disLbl = [[UILabel alloc]initWithFrame:RECT(5, CGRectGetMaxY(priceLbl.frame), self.frame.size.width - 10, 20)];
        disLbl.backgroundColor = [UIColor clearColor];
        disLbl.textColor = HexColor(@"6A6A6A");
        disLbl.font = FontWS(12);
        disLbl.adjustsFontSizeToFitWidth = YES;
        disLbl.minimumScaleFactor = 0.8;
        
        [self addSubview:disLbl];
        
        stockLbl = [[UILabel alloc]initWithFrame:RECT(5, CGRectGetMaxY(priceLbl.frame), self.frame.size.width - 10, 20)];
        stockLbl.backgroundColor = [UIColor clearColor];
        stockLbl.textAlignment = NSTextAlignmentRight;
        stockLbl.textColor = HexColor(@"6A6A6A");
        stockLbl.font = FontWS(12);
        [self addSubview:stockLbl];
        
        logo = [[UIImageView alloc]initWithFrame:RECT(0, 0, 58, 58)];
        logo.alpha = 0.7;
        logo.image = IMAGE(@"deals");
        [self addSubview:logo];
        
    }
    
    return self;
}

-(void)setType:(CellType )type{
    _type = type;
    if (_type == CellType_Deal) {
        logo.image = IMAGE(@"deals");
    }else if (_type == CellType_BuyOne){
        logo.image = IMAGE(@"buyone");
    }else if (_type == CellType_Bound){
        logo.image = IMAGE(@"bonded");
    }
}

-(void)setInfo:(NSDictionary *)info{
    _info = info ;
    
    [imageView setPreImageWithUrl:[_info strForKey:@"img"]];
    nameLbl.text = [_info strForKey:@"name"];
    if (_type == CellType_Deal) {

        NSString *price = Format2(MoneySign, [_info strForKey:@"price"]);
        NSString *strPrice = Format2(price, @"包邮");
        NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:strPrice];
        [attrString addAttribute:NSForegroundColorAttributeName value:[UIColor getHexColor:@"f0460e"] range:NSMakeRange(0, [price length])];
        priceLbl.attributedText = attrString;
        
        NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
        NSAttributedString *str = [[NSAttributedString alloc]initWithString:Format2(MoneySign, [_info strForKey:@"oldprice"]) attributes:attribtDic];
        lbl2.attributedText = str;
        
        disLbl.text = Format2([_info strForKey:@"discount"], @"折");
        stockLbl.text = Format2(@"剩余", [_info strForKey:@"stock"]);
    }else if (_type == CellType_BuyOne){

        
        NSString *price = Format2(MoneySign, [_info strForKey:@"price"]);
        NSString *strPrice = Format2(price, @" /2件 包邮(3-5天发货)");
        NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:strPrice];
        [attrString addAttribute:NSForegroundColorAttributeName value:[UIColor getHexColor:@"f0460e"] range:NSMakeRange(0, [price length])];
        priceLbl.attributedText = attrString;
        
        
        price = Format2(MoneySign, [_info strForKey:@"oldprice"]);
        strPrice = Format2(price, @"/1件");
        attrString = [[NSMutableAttributedString alloc] initWithString:strPrice];
        [attrString addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, [price length])];
        disLbl.attributedText = attrString;
        
        stockLbl.text = Format2(@"剩余", [_info strForKey:@"qtylimit"]);
    }else if (_type == CellType_Bound){
        NSString *price = Format2(MoneySign, [_info strForKey:@"price"]);
        NSString *strPrice = Format2(price, @" 免税");
        NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:strPrice];
        [attrString addAttribute:NSForegroundColorAttributeName value:[UIColor getHexColor:@"f0460e"] range:NSMakeRange(0, [price length])];
        priceLbl.attributedText = attrString;
        
    
        disLbl.text = @"保税品每人每天限购500元";
    }

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
