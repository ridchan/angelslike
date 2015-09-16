//
//  PayRecordCell.m
//  angelslike
//
//  Created by angelslike on 15/9/15.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import "PayRecordCell.h"

@implementation PayRecordCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //
        UIView *view = [[UIView alloc]initWithFrame:RECT(0, 20, ScreenWidth, 130)];
        view.backgroundColor = [UIColor whiteColor];
        lbl1 = [self lblWithFrame:RECT(10, 10, ScreenWidth - 20, 22)];
        [view addSubview:lbl1];
        
        lbl2 = [self lblWithFrame:RECT(10, 32, ScreenWidth - 20, 22)];
        [view addSubview:lbl2];
        
        lbl3 = [self lblWithFrame:RECT(10, 54, ScreenWidth - 20, 22)];
        [view addSubview:lbl3];
        
        lbl4 = [self lblWithFrame:RECT(10, 76, ScreenWidth - 20, 22)];
        [view addSubview:lbl4];
        
        lbl5 = [self lblWithFrame:RECT(10, 98, ScreenWidth - 20, 22)];
        [view addSubview:lbl5];
        
        //
        [view addline:CGPointMake(0, 0) color:nil];
        [view addline:CGPointMake(0, 130) color:nil];
        
        [self addSubview:view];
    }
    
    return self;
}

-(UILabel *)lblWithFrame:(CGRect)rect{
    UILabel *label = [[UILabel alloc] initWithFrame:rect];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = RGBA(0, 0, 0, 0.85);
    label.font = FontWS(13);
    
    return label;
}

-(void)setInfo:(NSDictionary *)info{
    _info = info;
    lbl1.text = Format2(@"订单编号 ", [_info strForKey:@"orderid"]);
    lbl2.text = Format3(@"金   额  ",@"￥", [_info strForKey:@"price"]);
    lbl3.text = Format2(@"支付类型 ", [_info strForKey:@"paytype"]);
    lbl4.text = Format2(@"时   间 ", [_info strForKey:@"time"]);
    lbl5.text = Format2(@"流水单号 ", [_info strForKey:@"transactionid"]);
    
}

@end
