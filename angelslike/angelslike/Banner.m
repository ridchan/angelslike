//
//  Banner.m
//  angelslike
//
//  Created by angelslike on 15/8/5.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import "Banner.h"

@implementation Banner

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
//        self.backgroundColor = [UIColor getHexColor:@"FFF000"];
        self.layer.borderWidth =  0.5;
        self.layer.borderColor = [UIColor getHexColor:@"e0e0e0"].CGColor;

        [self initial];
    }
    return self;
}

-(void)initial{
    UILabel *leftTitle = [[UILabel alloc ] init ];
    leftTitle.frame = CGRectMake(0, 0, self.frame.size.width / 2, self.frame.size.height);
    leftTitle.text = @"精品推荐";
    leftTitle.textAlignment = NSTextAlignmentCenter;
    leftTitle.font = [UIFont boldSystemFontOfSize:12];
    [self addSubview:leftTitle];
    
    UILabel *rightTitle = [[UILabel alloc ] init ];
    rightTitle.frame = CGRectMake(self.frame.size.width / 2, 0, self.frame.size.width / 2, self.frame.size.height);
    rightTitle.text = @"竟抽专区";
    rightTitle.textAlignment = NSTextAlignmentCenter;
    rightTitle.font = [UIFont boldSystemFontOfSize:12];
    [self addSubview:rightTitle];
    
    
    UIImageView *leftImage = [[UIImageView alloc]initWithFrame:CGRectMake(20, 20, 20, 20)];
    leftImage.image = [UIImage imageNamed:@"iconfont-icon83"];
    
    UIView *leftV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    leftV.center = leftImage.center;
    leftV.layer.cornerRadius =  20;
    leftV.layer.masksToBounds = YES;
    leftV.backgroundColor = [UIColor getHexColor:@"9bc63e"];
    [self addSubview:leftV];
    
    [self addSubview:leftImage];
    
    UIImageView *rightImage = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width / 2 + 20, 20, 20, 20)];
    rightImage.image = [UIImage imageNamed:@"iconfont-icon83"];
    UIView *rightV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    rightV.center = rightImage.center;
    rightV.layer.cornerRadius =  20;
    rightV.layer.masksToBounds = YES;
    rightV.backgroundColor = [UIColor getHexColor:@"a7a7ff"];
    [self addSubview:rightV];
    
    [self addSubview:rightImage];
    
    UIView *midline = [[UIView alloc]initWithFrame:CGRectMake(self.frame.size.width/2, 0, 0.5, self.frame.size.height)];
    midline.backgroundColor = [UIColor getHexColor:@"e0e0e0"];
    [self addSubview:midline];
}

-(void)layoutSubviews{
    [super layoutSubviews];

}


@end
