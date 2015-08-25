//
//  CommentCell.m
//  angelslike
//
//  Created by angelslike on 15/8/25.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import "CommentCell.h"


@implementation CommentCell

@synthesize info = _info;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //
        imageView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 30, 30)];
        [self addSubview:imageView];
        
        nameLabel =  [[UILabel alloc]initWithFrame:CGRectMake(40, 5, 100, 20)];
        nameLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:nameLabel];
        
        dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(40, 30, 100, 20)];
        dateLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:dateLabel];
        
        commentLabel = [[UILabel alloc]initWithFrame:CGRectMake(40, 45, 250, 40)];
        commentLabel.font = FontWS(11);
        commentLabel.numberOfLines = 0;
        [self addSubview:commentLabel];
    }
    
    return self;
}

-(void)setInfo:(NSDictionary *)info{
    _info = nil;
    _info = info;
    if (_info) {
        [imageView sd_setImageWithURL:[NSURL URLWithString:[_info strForKey:@"uimg"]] placeholderImage:[UIImage imageNamed:@"hui_logo"]];
        nameLabel.text = [_info strForKey:@"uname"];
        dateLabel.text = [_info strForKey:@"time"];
        commentLabel.text = [_info strForKey:@"comment"];
    }
    
}

@end
