//
//  UserInfoCell.m
//  angelslike
//
//  Created by angelslike on 15/8/12.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import "UserInfoCell.h"

@implementation UserInfoCell

@synthesize info = _info;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 130)];
        imageView.image = [UIImage imageNamed:@"my-bg"];
        [self addSubview: imageView];
        
        logo = [[UIImageView alloc]initWithFrame:CGRectMake(20, 100, 60, 60)];
        logo.layer.cornerRadius = 30;
        logo.layer.masksToBounds = YES;
        [self addSubview:logo];
        
        nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(100 , 100, 200, 30)];
        nameLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:nameLabel];
        
        moneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth / 3, 130, ScreenWidth / 3, 30)];
        moneyLabel.backgroundColor = [UIColor clearColor];
        moneyLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:moneyLabel];
        
        UILabel *title1 = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth / 3, 160, ScreenWidth / 3, 30)];
        title1.backgroundColor = [UIColor clearColor];
        title1.textAlignment = NSTextAlignmentCenter;
        title1.text = @"钱包";
        [self addSubview:title1];
        
        
        depositLabel = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth / 3 * 2, 130, ScreenWidth / 3, 30)];
        depositLabel.backgroundColor = [UIColor clearColor];
        depositLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:depositLabel];
        
        UILabel *title2 = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth / 3 * 2, 160, ScreenWidth / 3, 30)];
        title2.backgroundColor = [UIColor clearColor];
        title2.textAlignment = NSTextAlignmentCenter;
        title2.text = @"积分";
        [self addSubview:title2];
    }
    return self;
}



-(void)setInfo:(NSDictionary *)info{
    _info = [info mutableCopy];
    nameLabel.text = [_info strForKey:@"mname"];
    moneyLabel.text = [_info strForKey:@"mmoney"];
    depositLabel.text = [_info strForKey:@"mfen"];
    [logo setPreImageWithUrl:[_info strForKey:@"mimg"]];
}

@end
