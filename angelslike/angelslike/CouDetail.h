//
//  CouDetail.h
//  angelslike
//
//  Created by angelslike on 15/8/13.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeaderDefiner.h"
#import "CouProduct.h"
#import "CouProcess.h"

@interface DayLabel : UILabel

@end

@interface IconView : UIView{
    UIImageView *imgView1;
    UIImageView *imgView2;
    UIImageView *imgView3;
    UILabel *label1;
    UILabel *label2;
    UILabel *label3;
}

-(void)setFavitor:(NSString *)forward share:(NSString *)share views:(NSString *)views;

@end

@interface CouDetail : UIView<UIWebViewDelegate,CouProductDelegate,UIScrollViewDelegate>{
    UIScrollView *scView;
    
    UIImageView *imageView;
    UILabel *nameLabel;
    UILabel *timeStartLabel;
    UILabel *timeEndLabel;
    UILabel *statuLabel;
    
    UILabel *targetLabel;
    UILabel *priceLabel;
    UILabel *totalLabel;
    
    
    
    IconView *iconView;
    
    DayLabel *daylabel;
    UILabel *titlelabel;
    
    UIWebView *_webView;
    
    CouProduct *cp;
    CouProcess *process;
    
    RCRoundButton *inviteButton;
    
    UIView *tempView;
}

@property(nonatomic,strong) NSDictionary *info;

-(void)addToView:(UIView *)view;

@end
