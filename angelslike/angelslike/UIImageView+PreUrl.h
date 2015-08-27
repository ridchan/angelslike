//
//  UIImageView+PreUrl.h
//  angelslike
//
//  Created by angelslike on 15/8/27.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"

@interface UIImageView (PreUrl)

-(void)setPreImageWithUrl:(NSString *)link;
-(void)setPreImageWithUrl:(NSString *)link domain:(NSString *)domain;

@end
