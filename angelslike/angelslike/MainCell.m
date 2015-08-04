//
//  MainCell.m
//  angelslike
//
//  Created by angelslike on 15/8/4.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import "MainCell.h"


@implementation MainCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!imageView) {
        imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        [self addSubview:imageView];
    }
    if (!nameLabel) {
        nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.frame.size.height - 30, self.frame.size.width, 30)];
        nameLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:nameLabel];
    }
    return self;
}

-(void)setImageView:(NSString *)link{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:link]];
    [NSURLConnection sendAsynchronousRequest:request queue:nil completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        imageView.image = [[UIImage alloc]initWithData:data];
    }];
}

-(void)setName:(NSString *)name{
    nameLabel.text = name;
}

@end
