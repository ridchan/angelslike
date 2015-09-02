//
//  CircleButton.h
//  angelslike
//
//  Created by angelslike on 15/9/2.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeaderDefiner.h"

@interface CircleButton : UIView{
    id tar;
    SEL act;
}

-(void)addTarget:(id)target action:(SEL)action;
-(void)startAnimation:(BOOL)rotation;
@property(nonatomic) BOOL bRotation;

@end
