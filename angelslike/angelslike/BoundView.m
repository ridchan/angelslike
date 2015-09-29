//
//  BoundView.m
//  angelslike
//
//  Created by angelslike on 15/9/29.
//  Copyright © 2015年 angelslike. All rights reserved.
//

#import "BoundView.h"

@implementation BoundView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //
        self.backgroundColor = [UIColor whiteColor];
        [self initialAddress];
    }
    
    return self;
}

-(void)initialAddress{
    
    [self addSubview:[self labelName:@"真实姓名" frame:CGRectMake(10, 10, 100, 30)]];
    [self addSubview:[self labelName:@"身份证号码" frame:CGRectMake(10, 50, 100, 30)]];
    [self addSubview:[self labelName:@"电话" frame:CGRectMake(10, 90, 100, 30)]];
    [self addSubview:[self labelName:@"地址" frame:CGRectMake(10, 130, 100, 30)]];
    [self addSubview:[self labelName:@"详细地址" frame:CGRectMake(10, 170, 100, 30)]];
    
    
    [self addSubview:[self textField:CGRectMake(self.frame.size.width / 3, 10, self.frame.size.width / 3 * 2 - 10, 30) withTag:11]];
    [self addSubview:[self textField:CGRectMake(self.frame.size.width / 3, 50, self.frame.size.width / 3 * 2 - 10, 30) withTag:12]];
    [self addSubview:[self textField:CGRectMake(self.frame.size.width / 3, 90, self.frame.size.width / 3 * 2 - 10, 30) withTag:13]];
    mp = [[MutilePickerView alloc]initWithFrame:RECT(self.frame.size.width / 3, 125, self.frame.size.width / 3 * 2 - 10, 40)];
    mp.items = @[@"省",@"市",@"区"];
    mp.keys = @[@"pro",@"city",@"dis"];
    [self addSubview:mp];
    //    [self addSubview:[self textField:CGRectMake(self.frame.size.width / 3, 90, self.frame.size.width / 3 * 2 - 10, 30)]];
    [self addSubview:[self textField:CGRectMake(self.frame.size.width / 3, 170, self.frame.size.width / 3 * 2 - 10, 30) withTag:14]];
}


-(void)textChange:(UITextField *)textField{
    NSArray *arr = @[@"realname",@"idcard",@"phone",@"address"];
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
