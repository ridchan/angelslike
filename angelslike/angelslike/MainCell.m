//
//  MainCell.m
//  angelslike
//
//  Created by angelslike on 15/8/4.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import "MainCell.h"
#define margin 5


@implementation MainCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!imageView) {
        imageView = [[UIImageView alloc]init];
        [self addSubview:imageView];
    }
    
    if (!nameLabel) {
        nameLabel = [[UILabel alloc]init];
        nameLabel.font = [UIFont systemFontOfSize:14];
        nameLabel.backgroundColor = [UIColor clearColor];
        nameLabel.textColor = [UIColor whiteColor];
        [self addSubview:nameLabel];

    }
    
    return self;
}

-(void)setImageView:(NSString *)link{
//    NSString *newlink = [NSString stringWithFormat:@"http://%@",link];
    
    __block UIImageView *tempSelf = imageView;
    [imageView sd_setImageWithURL:[NSURL URLWithString:link] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        tempSelf.alpha = 0.2;
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
        [UIView animateWithDuration:0.3 animations:^{
            tempSelf.alpha = 1.0;
        }];
    }];

}

-(void)setName:(NSString *)name{
    nameLabel.text = name;
}

-(void)setConner:(UIImageView *)control{
    control.layer.cornerRadius = 5;
    control.layer.masksToBounds = YES;
//    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:control.bounds
//                                                   byRoundingCorners:UIRectCornerAllCorners
//                                                         cornerRadii:CGSizeMake(5.0, 5.0)];
//    CAShapeLayer *maskLayer = [CAShapeLayer layer];
//    maskLayer.frame         =  control.bounds;
//    maskLayer.path          = maskPath.CGPath;
//    control.layer.mask         = maskLayer;
}

- (CAGradientLayer *)shadowAsInverse
{
    CAGradientLayer *newShadow = [[CAGradientLayer alloc] init] ;
    CGRect newShadowFrame = CGRectMake(0, 0, self.frame.size.width - MainCellMargin * 2, 30);
    newShadow.frame = newShadowFrame;
    newShadow.cornerRadius = 5;
    newShadow.masksToBounds = YES;
    //添加渐变的颜色组合
    newShadow.colors = [NSArray arrayWithObjects:(id)[UIColor clearColor].CGColor,(id)[UIColor lightGrayColor].CGColor,nil];
    return newShadow;
}



-(void)layoutSubviews{
    [super layoutSubviews];
    imageView.frame = CGRectMake(MainCellMargin, 0, self.frame.size.width - MainCellMargin * 2, self.frame.size.height  - MainCellGap);
    [self setConner:imageView];
    nameLabel.frame =  CGRectMake(MainCellMargin, self.frame.size.height - 30 - MainCellGap, self.frame.size.width - MainCellMargin * 2, 30);
//    if (!layer) {
//        layer = [self shadowAsInverse];
//        [nameLabel.layer addSublayer:layer];
//        [nameLabel setNeedsDisplay];
//    }
    if (!imgLayer) {
        imgLayer = [CALayer layer];
        imgLayer.frame = CGRectMake(0, 0, imageView.frame.size.width, imageView.frame.size.height);
        imgLayer.contents = (id)[UIImage imageNamed:@"tbg"].CGImage;
        [imageView.layer addSublayer:imgLayer];
    }

}

@end
