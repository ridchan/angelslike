//
//  CouProcess.h
//  angelslike
//
//  Created by angelslike on 15/8/14.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeaderDefiner.h"
#import "ProgressView.h"

@interface CouProcess : UIView{
    UIImageView *img1;
    UIImageView *img2;
    UILabel *label1;
    UILabel *label2;
    ProgressView *progress;
}

@property(nonatomic,strong) UIColor *textColor;
-(void)setTarget:(NSString *)target complete:(NSString *)complete;

@end
