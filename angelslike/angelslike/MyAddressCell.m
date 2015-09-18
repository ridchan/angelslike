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
        self.clipsToBounds = YES;
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

-(void)setInfo:(NSMutableDictionary *)info{
    _info = info;
    self.bCheck = [_info intForKey:@"Address"] == 1;
    mp.items = @[[_info strForKey:@"pro"],[_info strForKey:@"city"],[_info strForKey:@"dis"]];
    [(UITextField *)[self viewWithTag:11] setText:[_info strForKey:@"username"]];
    [(UITextField *)[self viewWithTag:12] setText:[_info strForKey:@"address"]];
    [(UITextField *)[self viewWithTag:13] setText:[_info strForKey:@"phone"]];
}

-(void)initialAddress{
    [self addSubview:[self labelName:@"姓名" frame:CGRectMake(10, 50, 100, 30)]];
    [self addSubview:[self labelName:@"地址" frame:CGRectMake(10, 90, 100, 30)]];
    [self addSubview:[self labelName:@"详细地址" frame:CGRectMake(10, 130, 100, 30)]];
    [self addSubview:[self labelName:@"电话" frame:CGRectMake(10, 170, 100, 30)]];
    
    
    [self addSubview:[self textField:CGRectMake(self.frame.size.width / 3, 50, self.frame.size.width / 3 * 2 - 10, 30) withTag:11]];
    
    mp = [[MutilePickerView alloc]initWithFrame:RECT(self.frame.size.width / 3, 85, self.frame.size.width / 3 * 2 - 10, 40)];
    mp.items = @[@"省",@"市",@"区"];
    mp.keys = @[@"pro",@"city",@"dis"];
    [self addSubview:mp];
//    [self addSubview:[self textField:CGRectMake(self.frame.size.width / 3, 90, self.frame.size.width / 3 * 2 - 10, 30)]];
    [self addSubview:[self textField:CGRectMake(self.frame.size.width / 3, 130, self.frame.size.width / 3 * 2 - 10, 30) withTag:12]];
    [self addSubview:[self textField:CGRectMake(self.frame.size.width / 3, 170, self.frame.size.width / 3 * 2 - 10, 30) withTag:13]];
}


-(void)textChange:(UITextField *)textField{
    NSArray *arr = @[@"username",@"address",@"phone"];
    [self.info setObject:textField.text forKey:arr[textField.tag - 11]];
    
}

-(UITextField *)textField:(CGRect)frame withTag:(NSInteger)tag{
    UITextField *txt = [[UITextField alloc]initWithFrame:frame];
    txt.font = FontWS(14);
    txt.backgroundColor = HexColor(@"F8F8F8");
    txt.borderStyle = UITextBorderStyleNone;
    txt.layer.borderColor = HexColor(@"bbbbbb").CGColor;
    txt.layer.borderWidth = 1.0;
    txt.layer.cornerRadius = 4;
    txt.layer.masksToBounds = YES;
    txt.tag = tag;
    [txt addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
    return txt;
}

-(UILabel *)labelName:(NSString *)name frame:(CGRect)frame{
    UILabel *label1 = [[UILabel alloc]initWithFrame:frame];
    label1.backgroundColor = [UIColor clearColor];
    label1.text = name;
    return label1;
}


@end
