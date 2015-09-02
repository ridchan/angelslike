//
//  UIImageView+PreUrl.m
//  angelslike
//
//  Created by angelslike on 15/8/27.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import "UIImageView+PreUrl.h"

@implementation UIImageView (PreUrl)

-(void)setPreImageWithUrl:(NSString *)link{
    if ([link hasPrefix:@"http"]) {
        [self sd_setImageWithURL:[NSURL URLWithString:link] placeholderImage:[UIImage imageNamed:@"hui_logo"] ];
    }else{
        NSURL *url = [NSURL URLWithString:[@"http://img1.angelslike.com" stringByAppendingPathComponent:link]];
        [self sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"hui_logo"]];
    }
}

-(void)setPreImageWithUrl:(NSString *)link block:(ImageBlock)block{
    __block UIImageView *tempSelf = self;
    if ([link hasPrefix:@"http"]) {
        [self sd_setImageWithURL:[NSURL URLWithString:link] placeholderImage:[UIImage imageNamed:@"hui_logo"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            CGRect rect = CGRectZero;
            rect.origin = tempSelf.frame.origin;
            rect.size = CGSizeMake(tempSelf.frame.size.width, tempSelf.frame.size.width * image.size.height / image.size.width);
            tempSelf.frame = rect;
            block(nil);
        }];
    }else{
        NSURL *url = [NSURL URLWithString:[@"http://img1.angelslike.com" stringByAppendingPathComponent:link]];
        [self sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"hui_logo"]];
    }
}


-(void)setPreImageWithUrl:(NSString *)link domain:(NSString *)domain{
    if ([link hasPrefix:@"http"]) {
        NSURL *url = [NSURL URLWithString:link];
        [self sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"hui_logo"]];
    }else{
        NSURL *url = [NSURL URLWithString:[domain stringByAppendingPathComponent:link]];
        [self sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"hui_logo"]];
    }
}



@end
