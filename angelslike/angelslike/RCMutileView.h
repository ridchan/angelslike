//
//  RCMutileView.h
//  UMobile
//
//  Created by  APPLE on 2014/10/17.
//  Copyright (c) 2014年  APPLE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeaderDefiner.h"


@interface RCMutileView : UIView<UIScrollViewDelegate>{
    UIView *headerView;
    UIScrollView *scView;
    UIView *bottomView;
    NSUInteger count;
    BOOL bMoving;
}

@property(nonatomic,strong) NSArray *viewControllers;
@property(nonatomic,strong) NSArray *titles;
@property(nonatomic) NSUInteger selectIndex;
@property(nonatomic) BOOL bloadAll;

@end
