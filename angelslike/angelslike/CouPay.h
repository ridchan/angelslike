//
//  CouPay.h
//  angelslike
//
//  Created by angelslike on 15/8/28.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeaderDefiner.h"

@interface CouPay : UIView{
    UIView *backView;
    UIView *payView;
}

-(void)show;
-(void)dismiss;

@end
