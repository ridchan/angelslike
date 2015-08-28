//
//  ProductHeader.h
//  angelslike
//
//  Created by angelslike on 15/8/28.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeaderDefiner.h"

@interface ProductHeader : UIView{
    UIView *backView;
    
    UIImageView *img1;
    UIImageView *img2;
    UIImageView *img3;
    UIImageView *img4;
    
    RCRoundButton *button1;
    RCRoundButton *button2;
    RCRoundButton *button3;
    RCRoundButton *button4;
    
    CALayer *line;
    
    id target;
    SEL action;
}


-(void)addTarget:(id)tar action:(SEL)act;


@end
