//
//  BuyOneCell.m
//  angelslike
//
//  Created by angelslike on 15/10/9.
//  Copyright © 2015年 angelslike. All rights reserved.
//

#import "BuyOneCell.h"

@implementation BuyOneCell

- (void)awakeFromNib {
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        imageView = [[UIImageView alloc]initWithFrame:RECT(10, 10, ScreenWidth - 20, (ScreenWidth - 20)  * 9  / 20)];
        imageView.layer.shadowColor = [UIColor blackColor].CGColor;
        imageView.layer.shadowOffset = CGSizeMake(5, 5);
        imageView.layer.cornerRadius = 6.0;
        imageView.layer.masksToBounds = YES;
        [self addSubview:imageView];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    

    // Configure the view for the selected state
}

-(void)setInfo:(NSDictionary *)info{
    _info = info;
    [imageView setPreImageWithUrl:[_info strForKey:@"img"]];
}

@end
