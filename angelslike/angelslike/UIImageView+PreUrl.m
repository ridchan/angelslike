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
        [self sd_setImageWithURL:[NSURL URLWithString:link] placeholderImage:[UIImage imageNamed:@"hui_logo"]];
    }else{
        NSURL *url = [NSURL URLWithString:[@"http://img1.angelslike.com" stringByAppendingPathComponent:link]];
        [self sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"hui_logo"]];
    }
}

-(void)setPreImageWithUrl:(NSString *)link domain:(NSString *)domain{
    NSURL *url = [NSURL URLWithString:[domain stringByAppendingPathComponent:link]];
    [self sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"hui_logo"]];
}



@end
