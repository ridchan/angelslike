//
//  UIImageView+PreUrl.h
//  angelslike
//
//  Created by angelslike on 15/8/27.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"
#import "UIImage+RTTint.h"

typedef void(^ImageBlock)(id Obj);

@interface UIImageView (PreUrl)

-(void)setPreImageWithUrl:(NSString *)link;
-(void)setPreImageWithUrl:(NSString *)link block:(ImageBlock)block;
-(void)setPreImageWithUrl:(NSString *)link domain:(NSString *)domain;
-(void)setImageColor:(UIColor *)color;

@end
