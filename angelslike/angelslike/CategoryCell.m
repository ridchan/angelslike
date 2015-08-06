//
//  CategoryCell.m
//  angelslike
//
//  Created by angelslike on 15/8/6.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import "CategoryCell.h"

@implementation CellItem

@synthesize info = _info;

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //
        imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,frame.size.width, frame.size.width)];
        label = [[UILabel alloc]initWithFrame:CGRectMake(0, frame.size.width + 10, frame.size.width, 20)];
        label.font = FontWS(9);
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor = [UIColor clearColor];
        
        [self addSubview:imageView];
        [self addSubview:label];
        
    }
    return self;
}

-(void)setInfo:(NSDictionary *)info{
    _info = info;
    imageView.image =  [UIImage imageNamed:[info objectForKey:@"IMG"]];
    label.text = [info objectForKey:@"Name"];
}

@end

@implementation CategoryCell

-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat gap = 6;
    CGFloat width = (self.frame.size.width - gap * 10) / 5;
    
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0 , 0, self.frame.size.width, self.frame.size.height - 10)];
    v.layer.borderWidth = 0.5;
    v.layer.borderColor = [UIColor getHexColor:@"e0e0e0"].CGColor;
    v.backgroundColor = [UIColor whiteColor];
    [self addSubview:v];
    
    if (!titleLabel) {
        titleLabel = [[UILabel alloc]init];
        titleLabel.backgroundColor = [UIColor greenColor];
        titleLabel.textColor = [UIColor blackColor];
        [self addSubview:titleLabel];
    }
    titleLabel.frame = CGRectMake(0, 0, 200, 30);
    titleLabel.text = self.title;
    
    
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 30, self.frame.size.width, self.frame.size.height - 40)];

    [self addSubview:scrollView];
    
    for (int i  = 0 ; i < [self.buttonInfos count] ; i ++){
        CellItem *item = [[CellItem alloc]initWithFrame:CGRectMake(gap + (gap * 2 + width) * i, 0, width, scrollView.frame.size.height)];
        item.info = [self.buttonInfos objectAtIndex:i];
        [scrollView addSubview:item];
        scrollView.contentSize = CGSizeMake(item.frame.origin.x + item.frame.size.width, 1);
    }
    
    
}






@end
