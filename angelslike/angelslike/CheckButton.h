//
//  CheckButton.h
//  angelslike
//
//  Created by angelslike on 15/8/31.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CheckButton : UIView{
    UIImage *img1;
    UIImage *img2;
    
    UIImageView *imageView;
    UILabel *label;
    
    id tar;
    SEL act;
}

@property(nonatomic) BOOL selected;
@property(nonatomic) BOOL canUnselected;

-(void)initWithItem:(NSString *)title;

-(void)addTarget:(id)target action:(SEL)action;

@end
