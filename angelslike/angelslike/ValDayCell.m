//
//  ValDayCell.m
//  angelslike
//
//  Created by angelslike on 15/9/8.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import "ValDayCell.h"

@implementation ValDayCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        label = [[UILabel alloc]initWithFrame:RECT(10, 6, ScreenWidth - 20, 40)];
        label.backgroundColor = [UIColor clearColor];
        label.text = @"有效天数";
        label.font = FontWS(14);
        label.textColor = HexColor(@"666666");
        
        
        
        [self addSubview:label];
        
        
        textField =  [[UITextField alloc]initWithFrame:RECT(ScreenWidth - 70, 13.5, 60, 25)];
//        textField.backgroundColor = HexColor(@"");
        textField.delegate = self;
        textField.layer.borderColor = [UIColor lightGrayColor].CGColor;
        textField.layer.borderWidth = 1.0;
        textField.layer.masksToBounds = YES;
        textField.layer.cornerRadius = 5;
        
        
        [self addSubview:textField];
    }
    
    return self;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    UIViewController *vc =  [self findViewController:self];
    if ([vc respondsToSelector:@selector(valDayClick:)]) {
        [vc performSelector:@selector(valDayClick:) withObject:self];
    }
    return NO;
}




@end
