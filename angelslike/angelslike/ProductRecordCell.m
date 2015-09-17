//
//  ProductRecordCell.m
//  angelslike
//
//  Created by angelslike on 15/9/17.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import "ProductRecordCell.h"

@implementation ProductRecordCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        UIView *view = [[UIView alloc ] initWithFrame:RECT(0, 0, ScreenWidth, 60)];
        view.backgroundColor = [UIColor whiteColor];
        [self addSubview:view];
        imageView = [[UIImageView alloc]initWithFrame:RECT(5, 5, 50, 50)];
        imageView.layer.masksToBounds = YES;
        imageView.layer.cornerRadius = 25;
        [self addSubview:imageView];
        
        nameLbl = [[UILabel alloc]initWithFrame:RECT(60, 0, ScreenWidth - 70, 60)];
        nameLbl.backgroundColor = [UIColor clearColor];
        [self addSubview:nameLbl];
        
        timeLbl = [[UILabel alloc]initWithFrame:RECT(60, 0, ScreenWidth - 70, 60)];
        timeLbl.textColor = [UIColor lightGrayColor];
        timeLbl.textAlignment = NSTextAlignmentRight;
        timeLbl.font = FontWS(12);
        [self addSubview:timeLbl];
    }
    
    return self;
}

-(void)setInfo:(NSDictionary *)info{
    _info = info;
    [imageView setPreImageWithUrl:[_info strForKey:@"img"]];
    nameLbl.text = [_info strForKey:@"name"];
    timeLbl.text = [_info strForKey:@"time"];
}

@end
