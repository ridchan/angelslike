//
//  MineView.h
//  angelslike
//
//  Created by angelslike on 15/9/1.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeaderDefiner.h"

@interface MineView : UIView{
    UIImageView *imageView;
    UIView *contentView;
    BOOL bShow;
}

-(void)showContent;
-(void)show;
-(void)dismiss;


@end
