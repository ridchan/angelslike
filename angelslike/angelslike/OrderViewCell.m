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
        [self addSubview:order];
        
        statu = [[UILabel alloc]initWithFrame:RECT(5, 5, ScreenWidth - 10, 20)];
        statu.font = FontWS(11);
        statu.textAlignment = NSTextAlignmentRight;
        [self addSubview:statu];
        
        
        _tableView = [[UITableView alloc]initWithFrame:RECT(0, 25, 0, 0) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self addSubview:_tableView];
        
        payButton = [RCRoundButton buttonWithType:UIButtonTypeCustom];
        payButton.layer.borderColor = HexColor(@"F88F19").CGColor;
        [payButton setTitleColor:HexColor(@"F88F19") forState:UIControlStateNormal];
        [payButton setTitle:@"立即支付" forState:UIControlStateNormal];
        payButton.titleLabel.font = FontWS(11);
        payButton.radio = 5;
        payButton.frame = RECT(0, 0, 50, 25);
        
        [self addSubview:payButton];
        
        detailButton = [RCRoundButton buttonWithType:UIButtonTypeCustom];
        detailButton.layer.borderColor = HexColor(@"F88F19").CGColor;
        [detailButton setTitleColor:HexColor(@"F88F19") forState:UIControlStateNormal];
        [detailButton setTitle:@"查看详情" forState:UIControlStateNormal];
        detailButton.titleLabel.font = FontWS(11);
        detailButton.radio = 5;
        detailButton.frame = RECT(0, 0, 50, 25);
        
        [self addSubview:detailButton];
        
        
        
    }
    return self;
}


-(void)setInfo:(NSDictionary *)info{
    _info = info;
    

    order.text = Format2(@"订单编号:", [_info strForKey:@"orderid"]);
    statu.text = Format2(@"状态:", [_info strForKey:@"statustext"]);

    _tableView.frame = RECT(0, 25, ScreenWidth, 90 * [[_info objectForKey:@"detail"] count]);
    
    payButton.frame = RECT(ScreenWidth - 120, _tableView.frame.size.height + _tableView.frame.origin.y + 5, 50, 25);
    
    detailButton.frame = RECT(ScreenWidth - 60, _tableView.frame.size.height + _tableView.frame.origin.y + 5, 50, 25);

    [_tableView reloadData];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderDetailViewCell *cell =  [_tableView dequeueReusableCellWithIdentifier:@"ODCell"];
    if (cell == nil) {
        cell =  [[OrderDetailViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ODCell"];
    }
    NSDictionary *dic = [[self.info objectForKey:@"detail"] objectAtIndex:0];
    cell.info = dic;
    return cell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  [[_info objectForKey:@"detail"] count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}



@end
