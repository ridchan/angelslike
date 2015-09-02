//
//  CheckButton.m
//  angelslike
//
//  Created by angelslike on 15/8/31.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import "CheckButton.h"

@implementation CheckButton

@synthesize selected = _selected;

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initial];
    }
    return self;
}

-(instancetype)init{
    if (self =  [super init]) {
        [self initial];
    }
    return self;
}

-(void)initial{
    self.backgroundColor = [UIColor clearColor];
    
    img1 = [UIImage imageNamed:@"iconfont-check"];
    img2 = [UIImage imageNamed:@"iconfont-nocheck"];
    
    imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 32, 32)];
    imageView.image = img2;
    label = [[UILabel alloc]initWithFrame:CGRectMake(32, 0, 32, 32)];
    
    [self addSubview:imageView];
    [self addSubview:label];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    [self addGestureRecognizer:tap];
}

-(void)addTarget:(id)target action:(SEL)action{
    tar = target;
    act = action;
}

-(void)tap:(id)obj{
    if (self.canUnselected == NO && self.selected ) return;
    self.selected = !self.selected;
    if ([tar respondsToSelector:act]) {
        [tar performSelector:act withObject:self];
    }
}

-(void)setSelected:(BOOL)selected{
    _selected = selected;
    imageView.image = _selected?img1:img2;
}



-(void)initWithItem:(NSString *)title{
    CGSize size = CGSizeMake(320, 32);
    CGRect rect = [title boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:label.font} context:nil];
    label.text = title;
    label.frame = CGRectMake(32, 0, rect.size.width , 32);
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
