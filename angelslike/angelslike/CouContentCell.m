//
//  CouContentCell.m
//  angelslike
//
//  Created by angelslike on 15/9/7.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import "CouContentCell.h"

@implementation CouContentCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //
        textView  =  [[UITextView alloc]initWithFrame:RECT(10, 0, ScreenWidth - 5, 100)];
        [self addSubview:textView];
    }
    
    return self;
}

@end
