//
//  BuyOneDetailView.h
//  angelslike
//
//  Created by angelslike on 15/10/9.
//  Copyright © 2015年 angelslike. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeaderDefiner.h"

@protocol BuyOneDetailDelegate <NSObject>

-(void)beResize:(CGRect)rect;
-(void)checkButtonClick:(id)sender;

@end

@interface BuyOneDetailView : UIView{
    UIImageView *imageView;
    UILabel *nameLabel;
    UILabel *priceLabel;
    UILabel *stockLabel;
    RCWebView *contentLabel;
}

@property(nonatomic,weak) id<BuyOneDetailDelegate> delegate;
@property(nonatomic,strong) NSDictionary *info;
@property(nonatomic,copy) WebViewBlock block;

@end
