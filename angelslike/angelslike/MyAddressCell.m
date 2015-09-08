//
//  MyAddressCell.m
//  angelslike
//
//  Created by angelslike on 15/9/8.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import "MyAddressCell.h"

@implementation MyAddressCell

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
        cb = [[CheckButton alloc]initWithFrame:RECT(10, 8, 35, 35)];
        cb.userInteractionEnabled = NO;
        [self addSubview:cb];
        
        label = [[UILabel alloc]initWithFrame:RECT(50, 5, 200, 40)];
        label.backgroundColor = [UIColor clearColor];
        label.text = @"本人填写收货信息";
        [self addSubview:label];
        
        [self initialAddress];
    }
    
    return self;
}

-(void)setBCheck:(BOOL)bCheck{
    _bCheck = bCheck;
    cb.selected = _bCheck;
}

-(void)initialAddress{
    [self addSubview:[self labelName:@"姓名" frame:CGRectMake(10, 50, 100, 30)]];
    [self addSubview:[self labelName:@"地址" frame:CGRectMake(10, 90, 100, 30)]];
    [self addSubview:[self labelName:@"详细地址" frame:CGRectMake(10, 130, 100, 30)]];
    [self addSubview:[self labelName:@"电话" frame:CGRectMake(10, 170, 100, 30)]];
    
    [self addSubview:[self textField:CGRectMake(self.frame.size.width / 3, 50, self.frame.size.width / 3 * 2 - 10, 30)]];
    [self addSubview:[self textField:CGRectMake(self.frame.size.width / 3, 90, self.frame.size.width / 3 * 2 - 10, 30)]];
    [self addSubview:[self textField:CGRectMake(self.frame.size.width / 3, 130, self.frame.size.width / 3 * 2 - 10, 30)]];
    [self addSubview:[self textField:CGRectMake(self.frame.size.width / 3, 170, self.frame.size.width / 3 * 2 - 10, 30)]];
}

-(UITextField *)textField:(CGRect)frame{
    UITextField *txt = [[UITextField alloc]initWithFrame:frame];
    txt.font = FontWS(14);
    txt.backgroundColor = [UIColor getHexColor:@"F8F8F8"];
    txt.borderStyle = UITextBorderStyleNone;
    txt.layer.borderColor = [UIColor getHexColor:@"bbbbbb"].CGColor;
    txt.layer.borderWidth = 1.0;
    txt.layer.cornerRadius = 4;
    txt.layer.masksToBounds = YES;
    return txt;
}

-(UILabel *)labelName:(NSString *)name frame:(CGRect)frame{
    UILabel *label1 = [[UILabel alloc]initWithFrame:frame];
    label1.backgroundColor = [UIColor clearColor];
    label1.text = name;
    return label1;
}


@end
