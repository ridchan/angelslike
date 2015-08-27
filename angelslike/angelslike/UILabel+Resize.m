//
//  UILabel+Resize.m
//  angelslike
//
//  Created by angelslike on 15/8/27.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import "UILabel+Resize.h"

@implementation UILabel (Resize)

-(void)setTextResize:(NSString *)text{
    CGRect rect = [text boundingRectWithSize:CGSizeMake(self.frame.size.width, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.font} context:nil];
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, rect.size.height);
    [self setText:text];
}

@end
