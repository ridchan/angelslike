//
//  ImageScroller.h
//  angelslike
//
//  Created by angelslike on 15/8/4.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+NetWork.h"
#import "NetWork.h"
#import "UIImageView+WebCache.h"
#import "HeaderDefiner.h"


@interface DotPageControl : UIPageControl{
    UIImage *_activeImage;
    UIImage *_inactiveImage;
}


@end

@interface ImageScroller : UIView<UIScrollViewDelegate>{
    UIScrollView *_scrollView;
    UIPageControl *_pageControl;
    id tar;
    SEL sel;
    
}

@property(nonatomic,strong) NSArray *infos;
@property(nonatomic,strong) NSString *cdn;
@property(nonatomic) BOOL autoRun;

-(void)start:(NSString *)link;

-(void)addTarget:(id)target selector:(SEL)selector;



@end
