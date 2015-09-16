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
        
        imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 130)];
        imageView.image = [UIImage imageNamed:@"my-bg"];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:imageView];
        
        logo = [[UIImageView alloc]initWithFrame:CGRectMake(15, 90, 80, 80)];
        logo.layer.cornerRadius = 40;
        logo.layer.masksToBounds = YES;
        logo.userInteractionEnabled = YES;
        [self addSubview:logo];
        
        nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(100 , 100, 200, 30)];
        nameLabel.backgroundColor = [UIColor clearColor];
        nameLabel.textColor = [UIColor whiteColor];
        [self addSubview:nameLabel];
        
        
        self.wallent = [[UIView alloc]initWithFrame:RECT(ScreenWidth / 3, 145, ScreenWidth / 3, 60)];
        [self addSubview:self.wallent];
        
        
        moneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth / 3, 145, ScreenWidth / 3, 30)];
        moneyLabel.backgroundColor = [UIColor clearColor];
        moneyLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:moneyLabel];
        
        
        UILabel *title1 = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth / 3, 165, ScreenWidth / 3, 30)];
        title1.backgroundColor = [UIColor clearColor];
        title1.textAlignment = NSTextAlignmentCenter;
        title1.text = @"钱包";
        [self addSubview:title1];
        
        
        depositLabel = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth / 3 * 2, 145, ScreenWidth / 3, 30)];
        depositLabel.backgroundColor = [UIColor clearColor];
        depositLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:depositLabel];
        
        UILabel *title2 = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth / 3 * 2, 165, ScreenWidth / 3, 30)];
        title2.backgroundColor = [UIColor clearColor];
        title2.textAlignment = NSTextAlignmentCenter;
        title2.text = @"积分";
        [self addSubview:title2];
        
        _editButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _editButton.frame = RECT(ScreenWidth - 80, 14, 64, 28);
        [_editButton setBackgroundColor:RGBA(0, 0, 0, 0.4)];
        [_editButton setTitle:@"编辑" forState:UIControlStateNormal];
        _editButton.layer.masksToBounds = YES;
        _editButton.layer.cornerRadius = 14;
        [self addSubview:_editButton];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(offsetChange:) name:@"UserInfoCell" object:nil];
    }
    return self;
}

-(UIImageView *)imageView{
    return logo;
}

-(void)offsetChange:(NSNotification *)obj{
    NSNumber *num = (NSNumber *)obj.object;
    CGFloat scale = fabsf([num floatValue] + 64) / 100 + 1.0;
    imageView.frame = CGRectMake(0, [num floatValue] + 64, ScreenWidth, 130 * scale);
//    imageView.transform =  CGAffineTransformMakeScale(scale,scale);
}

-(void)setInfo:(NSDictionary *)info{
    _info = [info mutableCopy];
    nameLabel.text = [_info strForKey:@"name"];
    moneyLabel.text = [_info strForKey:@"money"];
    depositLabel.text = [_info strForKey:@"mfen"];
    [logo setPreImageWithUrl:[_info strForKey:@"img"] domain:MainUrl];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

@end
