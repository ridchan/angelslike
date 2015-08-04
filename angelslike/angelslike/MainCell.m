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
        imageView = [[UIImageView alloc]init];
        [self addSubview:imageView];
    }
    
    if (!nameLabel) {
        nameLabel = [[UILabel alloc]init];
        nameLabel.backgroundColor = [UIColor clearColor];
        nameLabel.textColor = [UIColor whiteColor];
        [self addSubview:nameLabel];

    }
    
    return self;
}

-(void)setImageView:(NSString *)link{
    NSString *newlink = [NSString stringWithFormat:@"http://%@",link];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:newlink]];
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        dispatch_async(dispatch_get_main_queue(), ^{
            imageView.image = [[UIImage alloc]initWithData:data];
        });
        
    }];
}

-(void)setName:(NSString *)name{
    nameLabel.text = name;
}

-(void)setConner:(UIImageView *)control{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:control.bounds
                                                   byRoundingCorners:UIRectCornerAllCorners
                                                         cornerRadii:CGSizeMake(5.0, 5.0)];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame         =  control.bounds;
    maskLayer.path          = maskPath.CGPath;
    control.layer.mask         = maskLayer;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    imageView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height  - 5);
    [self setConner:imageView];
    nameLabel.frame =  CGRectMake(0, self.frame.size.height - 30, self.frame.size.width, 30 - 5);
}

@end
