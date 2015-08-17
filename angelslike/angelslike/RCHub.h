//
//  RCHub.h
//  AMTumblrHudDemo
//
//  Created by ridchan on 15/8/11.
//  Copyright (c) 2015年 askar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RoundHub : UIView
    
@end

@interface RCHub : UIView{
    NSUInteger runningIdx;
}

@property(nonatomic,strong) UIWindow *window;
@property(nonatomic,strong) UIView *bview;
@property(nonatomic,strong) NSMutableArray *layers;

-(void)startAnimation;
-(void)stopAnimation;
+(void)show;
+(void)showMsg:(NSString *)msg;
+(void)dismiss;
+(instancetype)shared;

@end
