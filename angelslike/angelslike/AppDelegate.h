//
//  AppDelegate.h
//  angelslike
//
//  Created by angelslike on 15/8/4.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColor+HexColor.h"
#import "MainViewController.h"
#import "MainTabBar.h"
#import "TabBarViewController.h"
#import "CouViewController.h"
#import "CategoryViewController.h"
#import "MineViewController.h"
#import "IQKeyboardManager.h"
#import "WXApi.h"
#import "BaiduMobStat.h"


@interface AppDelegate : UIResponder <UIApplicationDelegate,WXApiDelegate>

@property (strong, nonatomic) UIWindow *window;


@end

