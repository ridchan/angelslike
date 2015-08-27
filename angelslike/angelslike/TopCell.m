//
//  TopCell.m
//  angelslike
//
//  Created by angelslike on 15/8/27.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import "TopCell.h"

@implementation TopCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //
        imageView =  [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenWidth * 9 /16)];
        content = [[UILabel alloc]initWithFrame:CGRectMake(5, ScreenWidth * 9 /16 + 20, ScreenWidth - 10, 50)];
        content.font = FontWS(17);
        content.backgroundColor = [UIColor clearColor];
        content.numberOfLines =  0;
        
        left = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 15, 15)];
        left.image = [UIImage imageNamed:@"leftcon"];
        
        right = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 15, 15)];
        right.image = [UIImage imageNamed:@"rightcon"];
        

        
        [self addSubview:imageView];
        [self addSubview:content];
        
        [self addSubview:left];
        [self addSubview:right];
        
    }
    return self;
}

-(void)setContent:(NSString *)text image:(NSString *)link{
    [imageView setPreImageWithUrl:link];
    NSString *ntext = [NSString stringWithFormat:@"    %@",text];
    CGRect rect = [ntext boundingRectWithSize:CGSizeMake(content.frame.size.width, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:FontWS(17)} context:nil];
    CGRect nrect = CGRectZero;
    nrect.origin = content.frame.origin;
    nrect.size = rect.size;
    content.frame = nrect;
    content.text = ntext;
    
    left.center = content.frame.origin;
    right.center = CGPointMake(content.frame.origin.x + content.frame.size.width ,content.frame.origin.y + content.frame.size.height - 15);
    
    self.frame = CGRectMake(0, 0, ScreenWidth, content.frame.size.height + content.frame.origin.y + 20);
    
}

@end
