//
//  CouImageCell.m
//  angelslike
//
//  Created by angelslike on 15/9/7.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import "CouImageCell.h"

@implementation CouImageCell

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
        imageView = [[UIImageView alloc]initWithFrame:RECT(10, 1, 30, 30)];
        imageView.image = IMAGE(@"download");
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:imageView];
        
        label = [[UILabel alloc]initWithFrame:RECT(0, 1, ScreenWidth - 5, 30)];
        label.textAlignment = NSTextAlignmentRight;
        label.text = @"最多上传9张图片";
        [self addSubview:label];
    }
    return self;
}

@end
