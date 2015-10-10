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
        order.backgroundColor = [UIColor clearColor];
        order.font = FontWS(11);
        [self.contentView addSubview:order];
        
        statu = [[UILabel alloc]initWithFrame:RECT(5, 5, ScreenWidth - 10, 20)];
        statu.font = FontWS(11);
        statu.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:statu];
        
        
        _tableView = [[UIView alloc]initWithFrame:RECT(0, 25, 0, 0)];
        _tableView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_tableView];
        
        
        payButton = [RCRoundButton buttonWithType:UIButtonTypeCustom];
        [payButton setBackgroundColor:[UIColor whiteColor]];
        payButton.layer.borderColor = HexColor(@"F88F19").CGColor;
        [payButton setTitleColor:HexColor(@"F88F19") forState:UIControlStateNormal];
        [payButton setTitle:@"立即支付" forState:UIControlStateNormal];
        payButton.titleLabel.font = FontWS(11);
        payButton.radio = 5;
        payButton.frame = RECT(0, 0, 50, 25);
        payButton.tag = OrderCellType_Pay;
        [payButton addTarget:self action:@selector(cellButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:payButton];
        
        detailButton = [RCRoundButton buttonWithType:UIButtonTypeCustom];
        [detailButton setBackgroundColor:[UIColor whiteColor]];
        detailButton.layer.borderColor = HexColor(@"F88F19").CGColor;
        [detailButton setTitleColor:HexColor(@"F88F19") forState:UIControlStateNormal];
        [detailButton setTitle:@"查看详情" forState:UIControlStateNormal];
        detailButton.titleLabel.font = FontWS(11);
        detailButton.radio = 5;
        detailButton.frame = RECT(0, 0, 50, 25);
        detailButton.tag = OrderCellType_Detail;
        [detailButton addTarget:self action:@selector(cellButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:detailButton];
        
        
        
    }
    return self;
}

-(void)addTarget:(id)target action:(SEL)action{
    tar = target;
    act = action;
}

-(void)cellButtonClick:(UIButton *)button{
    if ([tar respondsToSelector:act]) {
        [tar performSelector:act withObject:button];
    }
}


-(void)setInfo:(NSDictionary *)info{
    _info = info;
    

    order.text = Format2(@"订单编号:", [_info strForKey:@"orderid"]);
    statu.text = Format2(@"状态:", [_info strForKey:@"statustext"]);

    
    [_tableView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [_tableView addline:CGPointMake(0, 1) color:nil];
    _tableView.frame = RECT(0, 25, ScreenWidth, 90 * [[_info objectForKey:@"detail"] count]);
    [_tableView addline:CGPointMake(0, _tableView.frame.size.height) color:nil];
    for (int i = 0 ; i < [[_info objectForKey:@"detail"] count] ; i ++ ){
        OrderDetailView *od = [[OrderDetailView alloc]initWithFrame:RECT(0, 90 * i, ScreenWidth, 90)];
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:[_info objectForKey:@"detail"][i]];
        [dic setObject:[_info strForKey:@"time"] forKey:@"time"];
        [dic setObject:[_info strForKey:@"paytype"] forKey:@"paytype"];
        od.info = dic;
        [_tableView addSubview:od];
    }
    
    payButton.frame = RECT(ScreenWidth - 120, _tableView.frame.size.height + _tableView.frame.origin.y + 5, 50, 25);
    
    detailButton.frame = RECT(ScreenWidth - 60, _tableView.frame.size.height + _tableView.frame.origin.y + 5, 50, 25);
    if ([_info intForKey:@"status"] != 1) payButton.hidden = YES;
    self.frame = RECT(0, 0, ScreenWidth, CGRectGetMaxY(detailButton.frame));
}





@end
