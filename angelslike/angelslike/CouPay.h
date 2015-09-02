//
//  CouPay.h
//  angelslike
//
//  Created by angelslike on 15/8/28.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeaderDefiner.h"
#import "QtyButton.h"
#import "CheckButton.h"


@interface CouPay : UIView{
    UIView *backView;
    UIView *payView;
    id tar;
    SEL act;
}

-(void)show;
-(void)dismiss;
-(void)addTarget:(id)target action:(SEL)action;

@property(nonatomic,strong) NSMutableDictionary *info;

@end
