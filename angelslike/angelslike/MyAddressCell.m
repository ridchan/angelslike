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
    self.bCheck = [[_info strForKey:@"Address"] isEqualToString:@"MY"];
}

-(void)initialAddress{
    [self addSubview:[self labelName:@"姓名" frame:CGRectMake(10, 50, 100, 30)]];
    [self addSubview:[self labelName:@"地址" frame:CGRectMake(10, 90, 100, 30)]];
    [self addSubview:[self labelName:@"详细地址" frame:CGRectMake(10, 130, 100, 30)]];
    [self addSubview:[self labelName:@"电话" frame:CGRectMake(10, 170, 100, 30)]];
    
    [self addSubview:[self textField:CGRectMake(self.frame.size.width / 3, 50, self.frame.size.width / 3 * 2 - 10, 30)]];
    [self SelectAddress];
//    [self addSubview:[self textField:CGRectMake(self.frame.size.width / 3, 90, self.frame.size.width / 3 * 2 - 10, 30)]];
    [self addSubview:[self textField:CGRectMake(self.frame.size.width / 3, 130, self.frame.size.width / 3 * 2 - 10, 30)]];
    [self addSubview:[self textField:CGRectMake(self.frame.size.width / 3, 170, self.frame.size.width / 3 * 2 - 10, 30)]];
}

-(void)SelectAddress{
    NSArray *arr = @[@"省",@"市",@"区"];
    CGFloat width = ((self.frame.size.width / 3 * 2 - 10) - 10) / 3;
    CGFloat left = self.frame.size.width / 3;
    for (int i  = 0 ; i < 3 ; i ++){
        PickerView *pk = [[PickerView alloc]initWithFrame:RECT(left + (width + 5) * i , 90, width, 30)];
        pk.tag = i + 1;
        pk.text = [arr objectAtIndex:i];
        [pk addTarget:self action:@selector(addressSelect:)];
        [self addSubview:pk];
    }
}

-(void)addressSelect:(PickerView *)pk{
    NSString *type = @"";
    if (pk.tag == 1) {
        type = @"pro";
    }else if (pk.tag == 2){
        type = @"city";
    }else{
        type = @"dis";
    }
 
    id address = [UserDefault objectForKey:type];
    if (!address) {
        [[NetWork shared]query:AddressUrl info:@{@"type":type} block:^(id Obj) {
            id newAddress = [Obj objectForKey:@"data"];
            [UserDefault setObject:newAddress forKey:type];
            
            if (pk.tag == 1) {
                [self showSelection:newAddress picker:pk];
            }else if (pk.tag == 2){
                PickerView *pk1 = (PickerView *)[self viewWithTag:1];
                NSArray *newArr = [newAddress objectForKey:pk1.text];
                [self showSelection:newArr picker:pk];
            }else{
                PickerView *pk2 = (PickerView *)[self viewWithTag:2];
                NSArray *newArr = [newAddress objectForKey:pk2.text];
                [self showSelection:newArr picker:pk];
            }
        } lock:NO];
    }else{
        if (pk.tag == 1) {
            [self showSelection:address picker:pk];
        }else if (pk.tag == 2){
            PickerView *pk1 = (PickerView *)[self viewWithTag:1];
            NSArray *newArr = [address objectForKey:pk1.text];
            [self showSelection:newArr picker:pk];
        }else{
            PickerView *pk2 = (PickerView *)[self viewWithTag:2];
            NSArray *newArr = [address objectForKey:pk2.text];
            [self showSelection:newArr picker:pk];
        }
    }

}

-(void)showSelection:(NSArray *)arr picker:(PickerView *)pk{
    SGPopSelectView *popView = [[SGPopSelectView alloc] init];
    popView.selections = arr;
    __block SGPopSelectView *tempView = popView;
    popView.selectedHandle = ^(NSInteger selectedIndex){
        pk.text = tempView.selections[selectedIndex];
        [tempView hide:NO];
    };
    
    UIWindow * window=[[[UIApplication sharedApplication] delegate] window];
    CGRect rect=[pk convertRect:pk.bounds toView:window];
    
    [popView showFromView:window atPoint:rect.origin animated:YES];
}


-(UITextField *)textField:(CGRect)frame{
    UITextField *txt = [[UITextField alloc]initWithFrame:frame];
    txt.font = FontWS(14);
    txt.backgroundColor = HexColor(@"F8F8F8");
    txt.borderStyle = UITextBorderStyleNone;
    txt.layer.borderColor = HexColor(@"bbbbbb").CGColor;
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
