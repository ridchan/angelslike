//
//  ProductDetailViewController.h
//  angelslike
//
//  Created by angelslike on 15/8/25.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import "BaseViewController.h"
#import "ProductDetail.h"
#import "RCMutileView.h"
#import "WebViewController.h"
#import "CommentViewController.h"
#import "BuyNowViewController.h"

@interface ProductDetailViewController : BaseViewController<UIScrollViewDelegate>{
    ProductDetail *pd;
    RCMutileView *mv;
    UIScrollView *scView;
}

@property(nonatomic,strong) NSDictionary *info;
@property(nonatomic,strong) NSDictionary *result;



@end
