//
//  CouTitleCell.m
//  angelslike
//
//  Created by angelslike on 15/9/7.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import "CouTitleCell.h"

@implementation CouTitleCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        text = [[UITextField alloc]initWithFrame:RECT(10, 3.5, ScreenWidth - 50, 30)];
        text.borderStyle = UITextBorderStyleNone;
        text.placeholder = @"标题";
        text.delegate = self;
        [text addTarget:self action:@selector(valueChange:) forControlEvents:UIControlEventEditingChanged];
        [self addSubview:text];
        
        label = [[UILabel alloc]initWithFrame:RECT(ScreenWidth - 50, 3.5, 50, 30)];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = HexColor(@"5C5959");
        label.text = @"0/20";
        [self addSubview:label];
    }
    return self;
}

-(void)valueChange:(id)obj{
    label.text = [NSString stringWithFormat:@"%ld/20",[text.text length]];
    [self.info setObject:text.text forKey:@"title"];
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([textField.text length] >= 20 && [string length] > 0) {
        return NO;
    }
    
    return YES;
}

@end
