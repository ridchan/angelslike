//
//  ProductDetail.h
//  angelslike
//
//  Created by angelslike on 15/8/25.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeaderDefiner.h"

@protocol ProductDetailDelegate <NSObject>



@end

@interface ProductDetail : UIView<UIWebViewDelegate>{
    UIImageView *imageView;
    UILabel *namelabel;
    UILabel *pricelabel;
    UIWebView *content;
    UILabel *lbl1;
    UILabel *lbl2;
    UILabel *lbl3;
}

-(void)setInfo:(NSDictionary *)info;


@end
