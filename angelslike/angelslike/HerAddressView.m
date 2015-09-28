//
//  HerAddressView.m
//  angelslike
//
//  Created by angelslike on 15/9/28.
//  Copyright © 2015年 angelslike. All rights reserved.
//

#import "HerAddressView.h"

@implementation HerAddressView


-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //
        self.backgroundColor = [UIColor whiteColor];
        cb = [[CheckButton alloc]initWithFrame:RECT(10, 8, 30, 30)];
        cb.userInteractionEnabled = NO;
        [self addSubview:cb];
        
        label = [[UILabel alloc]initWithFrame:RECT(50, 5, ScreenWidth - 60, 40)];
        label.backgroundColor = [UIColor clearColor];
        label.text = @"由收礼物人填写收货信息";
        [self addSubview:label];
        
        desc = [[UILabel alloc]initWithFrame:RECT(50, 40, ScreenWidth - 60, 40)];
        desc.backgroundColor = [UIColor clearColor];
        desc.font = FontWS(11);
        desc.numberOfLines = 2;
        desc.textColor = HexColor(@"F44236");
        desc.text = @"付款后发送给收礼人，ta只需填上收货信息，快递会直接把礼物送给ta了．";
        [self addSubview:desc];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(viewTap:)];
        [self addGestureRecognizer:tap];
    }
    
    return self;
}

-(void)viewTap:(id)obj{
    [self setBCheck:!_bCheck];
}

-(void)setBCheck:(BOOL)bCheck{
    _bCheck = bCheck;
    cb.selected = _bCheck;
    if (_block) {
        _block([NSNumber numberWithBool:bCheck]);
    }
}

@end
