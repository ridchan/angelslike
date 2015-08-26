//
//  AddressCell.m
//  angelslike
//
//  Created by angelslike on 15/8/26.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import "AddressCell.h"

@implementation AddressCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.textField = [[UITextField alloc]initWithFrame:CGRectMake(100, 7, ScreenWidth - 110, 30)];
        self.textField.borderStyle =  UITextBorderStyleRoundedRect;
        self.textField.backgroundColor = [UIColor getHexColor:@"F8F8F8"];

        [self addSubview:self.textField];
    }
    return self;
}



@end
