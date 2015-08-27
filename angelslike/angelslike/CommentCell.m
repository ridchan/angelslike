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
        backView = [[UIView alloc]initWithFrame:CGRectMake(0, 5, self.frame.size.width, 80)];
        backView.backgroundColor = [UIColor whiteColor];
        [self addSubview:backView];
        
        self.backgroundColor = [UIColor clearColor];
        imageView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 10, 30, 30)];
        [self addSubview:imageView];
        
        nameLabel =  [[UILabel alloc]initWithFrame:CGRectMake(40, 10, 200, 20)];
        nameLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:nameLabel];
        
        dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(40, 30, 200, 20)];
        dateLabel.backgroundColor = [UIColor clearColor];
        dateLabel.font = FontWS(9);
        [self addSubview:dateLabel];
        
        commentLabel = [[UILabel alloc]initWithFrame:CGRectMake(40, 55, 250, 20)];
        commentLabel.font = FontWS(11);
        commentLabel.lineBreakMode = NSLineBreakByWordWrapping;
        commentLabel.numberOfLines = 99;
        [self addSubview:commentLabel];
        
        
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
        commentLabel.text = [_info strForKey:@"content"];
        CGRect rect = [commentLabel.text boundingRectWithSize:CGSizeMake(commentLabel.frame.size.width, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:commentLabel.font} context:nil];
        
        commentLabel.frame = CGRectMake(commentLabel.frame.origin.x, commentLabel.frame.origin.y, commentLabel.frame.size.width, rect.size.height);
        backView.frame = CGRectMake(0, 5, backView.frame.size.width ,commentLabel.frame.origin.y + commentLabel.frame.size.height);
//        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, commentLabel.frame.origin.y + commentLabel.frame.size.height);
        
    }
    
}

@end
