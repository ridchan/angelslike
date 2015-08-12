//
//  CouDetailViewController.h
//  angelslike
//
//  Created by angelslike on 15/8/12.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface CouDetailViewController : BaseViewController<UIWebViewDelegate>

@property(nonatomic,strong) NSDictionary *info;

@end
