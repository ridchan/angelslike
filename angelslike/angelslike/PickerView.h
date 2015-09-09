//
//  PickerView.h
//  angelslike
//
//  Created by angelslike on 15/9/9.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeaderDefiner.h"

@interface PickerView : UIView{
    UILabel *label;
    CALayer *layer;
    id tar;
    SEL act;
}

@property(nonatomic) BOOL selected;
@property(nonatomic,strong) NSString *text;

-(void)addTarget:(id)target action:(SEL)action;

@end
