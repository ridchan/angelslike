//
//  RCRefresher.h
//  angelslike
//
//  Created by angelslike on 15/8/20.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RCRefresher;

@interface UIScrollView (RefreshHeader)


@property(strong,nonatomic) RCRefresher *header;

@end

@interface RCRefresher : UIView{
    UIView *anView;
    BOOL loading ;
    CGFloat topInset;
    UIScrollView *_scrollView;
}


@property(nonatomic,strong) NSMutableArray *layers;

-(void)show;
-(void)dismiss;
-(void)startAnimation;

-(void)bindToView:(UIView *)v;

@end
