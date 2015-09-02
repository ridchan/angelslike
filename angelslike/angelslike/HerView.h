//
//  HerView.h
//  angelslike
//
//  Created by angelslike on 15/9/1.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeaderDefiner.h"

@interface HerView : UIView{
    UIImageView *imageView;
    UIView *contentView;
    BOOL bShow;
}

-(void)show;
-(void)dismiss;

@end
