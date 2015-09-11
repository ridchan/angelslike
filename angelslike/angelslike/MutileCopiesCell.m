//
//  MutileCopiesCell.m
//  angelslike
//
//  Created by angelslike on 15/9/8.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import "MutileCopiesCell.h"

@implementation MutileCopiesCell

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
        label = [[UILabel alloc]initWithFrame:RECT(10, 6, ScreenWidth - 20, 40)];
        label.text = @"可以凑多份";
        label.font = FontWS(14);
        label.textColor = HexColor(@"666666");
        [self addSubview:label];
        desc = [[UILabel alloc]initWithFrame:RECT(ScreenWidth / 3, 6, ScreenWidth / 2, 40)];
        desc.font = FontWS(12);
        desc.textColor = HexColor(@"959595");
        desc.text = @"可以凑多份";
        [self addSubview:desc];
        cb = [[CheckButton alloc]initWithFrame:RECT(ScreenWidth - 40, 11, 30, 30)];
        cb.canUnselected = YES;
        [self addSubview:cb];
    }
    
    return self;
}

-(BOOL)bCheck{
    return cb.selected;
}

-(void)setBCheck:(BOOL)bCheck{
    cb.selected = bCheck;
}

@end
