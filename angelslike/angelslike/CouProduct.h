//
//  CouProduct.h
//  angelslike
//
//  Created by angelslike on 15/8/14.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeaderDefiner.h"


@protocol CouProductDelegate <NSObject>

-(void)beResize:(CGRect)rect;
-(void)checkButtonClick:(id)sender;

@end

@interface CouProduct : UIView<UIWebViewDelegate>{
    UIImageView *imageView;
    UILabel *nameLabel;
    UILabel *priceLabel;
    UIWebView *contentLabel;
}


@property(nonatomic,weak) id<CouProductDelegate> delegate;

-(CGRect)setImg:(NSString *)link name:(NSString *)name price:(NSString *)price content:(NSString *)content;

@end
