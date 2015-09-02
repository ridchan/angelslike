//
//  QtyButton.h
//  angelslike
//
//  Created by angelslike on 15/8/31.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeaderDefiner.h"

@interface QtyButton : UIView{
    id tar;
    SEL act;
    UIButton *button1;
    UIButton *button2;
    UILabel *label;
}

-(void)addTarget:(id)target action:(SEL)action;

@property(nonatomic,strong) NSString *qty;
@property(nonatomic) NSInteger style;

@end
