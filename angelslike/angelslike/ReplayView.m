//
//  ReplayView.m
//  angelslike
//
//  Created by angelslike on 15/9/7.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import "ReplayView.h"

@implementation ReplayView


@synthesize info = _info;

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //
        self.clipsToBounds = YES;
        backView = [[UIView alloc]initWithFrame:CGRectMake(0, 5, self.frame.size.width, 80)];
        backView.layer.cornerRadius = 15;
        backView.layer.masksToBounds = YES;
        backView.backgroundColor = HexColor(@"F7F7F7");
        [self addSubview:backView];
        
        self.backgroundColor = [UIColor clearColor];
        imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15, 40, 40)];
        imageView.layer.cornerRadius = 20;
        imageView.layer.masksToBounds = YES;
        [self addSubview:imageView];
        
        nameLabel =  [[UILabel alloc]initWithFrame:CGRectMake(60, 15, 200, 20)];
        nameLabel.backgroundColor = [UIColor clearColor];
        nameLabel.font = FontWS(14);
        [self addSubview:nameLabel];
        
        dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, 40, 200, 10)];
        dateLabel.backgroundColor = [UIColor clearColor];
        dateLabel.textColor = HexColor(@"7B7B7B");
        dateLabel.font = FontWS(9);
        [self addSubview:dateLabel];
        
        commentLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, 55, self.frame.size.width - 65, 20)];
        commentLabel.font = FontWS(14);
        commentLabel.lineBreakMode = NSLineBreakByWordWrapping;
        commentLabel.numberOfLines = 99;
        [self addSubview:commentLabel];
        
        UIImageView *img1 = [[UIImageView alloc]initWithFrame:CGRectMake(260, 15, 20, 20)];
        img1.image = [[UIImage imageNamed:@"iconfont-pinglun"] rt_tintedImageWithColor:HexColor(@"797979")];
        [self addSubview:img1];
        
        UIImageView *img2 = [[UIImageView alloc]initWithFrame:CGRectMake(290, 15, 20, 20)];
        img2.image = [[UIImage imageNamed:@"iconfont-dianzan"] rt_tintedImageWithColor:HexColor(@"797979")];
        [self addSubview:img2];
        
        
    }
    
    return self;
}

-(void)setInfo:(NSDictionary *)info{
    _info = nil;
    _info = info;
    if (_info) {
        [imageView setPreImageWithUrl:[_info strForKey:@"img"] domain:MainUrl];
        nameLabel.text = [_info strForKey:@"name"];
        dateLabel.text = [_info strForKey:@"time"];
        commentLabel.text = [_info strForKey:@"title"];
        CGRect rect = [commentLabel.text boundingRectWithSize:CGSizeMake(commentLabel.frame.size.width, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:commentLabel.font} context:nil];
        
        commentLabel.frame = CGRectMake(commentLabel.frame.origin.x, commentLabel.frame.origin.y, commentLabel.frame.size.width, rect.size.height + 5);
        backView.frame = CGRectMake(0, 1, backView.frame.size.width ,commentLabel.frame.origin.y + commentLabel.frame.size.height);
        
        self.frame = CGRectMake(self.frame.origin.x , self.frame.origin.y, self.frame.size.width ,backView.frame.origin.y + backView.frame.size.height + 2);
        
    }
    
}


@end
