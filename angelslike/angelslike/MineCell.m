//
//  MineCell.m
//  angelslike
//
//  Created by angelslike on 15/8/7.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import "MineCell.h"
#define CellGap 10

@implementation MineCell

@synthesize info = _info;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

-(void)setInfo:(NSDictionary *)info{
    _info = info;
    if (!imageView) {
        imageView = [[UIImageView alloc]initWithFrame:CGRectMake( CellGap * 2,  CellGap, self.frame.size.height -  CellGap * 2, self.frame.size.height - CellGap * 2)];
        [self addSubview:imageView];
    }
    imageView.image = [UIImage imageNamed:[info objectForKey:@"IMG"]];

    
    if (!label) {
        label = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.height + CellGap * 2, 0, 200, self.frame.size.height)];
        label.backgroundColor = [UIColor clearColor];
        [self addSubview:label];
    }
    
    label.text = [info objectForKey:@"Name"];
}

@end
