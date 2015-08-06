//
//  DropDownList.m
//  angelslike
//
//  Created by angelslike on 15/8/6.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import "DropDownList.h"

@implementation DropDownList

-(void)addTarget:(id)target action:(SEL)action{
    tar = target;
    act = action;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
    }
    
    return self;
}

-(void)initialSetting{
    
}


@end
