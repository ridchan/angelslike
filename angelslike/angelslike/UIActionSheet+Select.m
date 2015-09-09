//
//  UIActionSheet+Select.m
//  angelslike
//
//  Created by angelslike on 15/9/9.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import "UIActionSheet+Select.h"

@implementation UIActionSheet (Select)

-(void)showInView:(UIView *)view{
    
}

-(void)showInBlockView:(UIView *)view{
    [self showInView:view];
    [[NSRunLoop mainRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:1.0]];
    
}

@end
