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
        label = [[UILabel alloc]initWithFrame:CGRectMake(0, frame.size.width + 2, frame.size.width, 20)];
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

@synthesize buttonInfos = _buttonInfos;
@synthesize title = _title;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //
        [self initialSetting];
    }
    
    return self;
}

-(void)setButtonInfos:(NSArray *)buttonInfos{
    _buttonInfos = buttonInfos;
    CGFloat gap = 6;
    CGFloat width = (ScreenWidth - CatCellMargin * 2 - gap * 10) / 5;
    
    [_scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    for (int i  = 0 ; i < [_buttonInfos count] ; i ++){
        CellItem *item = [[CellItem alloc]initWithFrame:CGRectMake(gap + (gap * 2 + width) * i, 0, width, _scrollView.frame.size.height)];
        item.info = [_buttonInfos objectAtIndex:i];
        [_scrollView addSubview:item];
        _scrollView.contentSize = CGSizeMake(item.frame.origin.x + item.frame.size.width + gap, 1);
    }
}

-(void)setTitle:(NSString *)title{
    _title = title;
    titleLabel.text = _title;
}


-(void)initialSetting{

    
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(CatCellMargin , 0, ScreenWidth - CatCellMargin * 2, CatCellHeight)];
    v.layer.borderWidth = 0.5;
    v.layer.borderColor = [UIColor getHexColor:@"e0e0e0"].CGColor;
    v.backgroundColor = [UIColor whiteColor];
    [self addSubview:v];
    
    
    titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(CatCellMargin + 10, 0, 200, 30)];
    
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.font = FontWS(11);
    
    [self addSubview:titleLabel];
    
    
    
    
    //    [self addSubview:titleLabel];
    
    
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 30, v.frame.size.width, v.frame.size.height - 30)];
    _scrollView.backgroundColor = [UIColor clearColor];
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:_scrollView];
    

}

-(void)layoutSubviews{
    [super layoutSubviews];
}






@end
