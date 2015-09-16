//
//  BaseViewController.h
//  angelslike
//
//  Created by angelslike on 15/8/6.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColor+HexColor.h"
#import "HeaderDefiner.h"
#import "NetWork.h"
#import "RCHub.h"
#import <ShareSDK/ShareSDK.h>


@interface BaseViewController : UIViewController

-(void)setTextFieldAttribute:(UITextField *)textField img:(NSString *)imgName bottom:(NSInteger)txtType;

-(CAShapeLayer *)createBound:(CGRect)rect bottom:(NSInteger)txtType;

-(void)showMessage:(NSString *)msg;
-(void)showHudMsg:(NSString *)msg;

-(void)reSizeImage:(NSMutableString *)result;

-(void)hideTabBar;
-(void)showTabbar;

-(BOOL)checkScrollView:(UIScrollView *)scrollView;
-(BOOL)showNetworkError:(BOOL)err;
-(void)refreshClick:(id)sender;
-(CAShapeLayer *)lineLayer:(CGPoint)position;
- (UIViewController *)findViewController:(UIView *)sourceView;
-(void)setBackButtonAction:(SEL)action;

-(UITableViewCell *)GetSuperCell:(UIView *)view;
-(void)shareContent:(NSString *)content title:(NSString *)title imagePath:(NSString *)path url:(NSString *)url;

@end
