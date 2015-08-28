//
//  BottomView.h
//  angelslike
//
//  Created by angelslike on 15/8/28.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeaderDefiner.h"

@interface BottomView : UIView{
    UIImageView *img1;
    UIImageView *img2;
    UIImageView *img3;
    
    UILabel *label1;
    UILabel *label2;
    UILabel *label3;
    
    
    UIButton *button1;
    UIButton *button2;
    UIButton *button3;
    
    id target;
    SEL action;
}


-(void)addTarget:(id)tar action:(SEL)act;

-(void)setCount:(NSString *)str count2:(NSString *)str2 count3:(NSString *)str3;

@end
