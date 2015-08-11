//
//  TabBarViewController.h
//  angelslike
//
//  Created by ridchan on 15/8/6.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainTabBar.h"
#import "HeaderDefiner.h"
#import "LoginViewController.h"
#import "GuideViewController.h"

@interface TabBarViewController : UITabBarController<MainTabBarDelgate>{
    MainTabBar *tabbar;
}

@end
