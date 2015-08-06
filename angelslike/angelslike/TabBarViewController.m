//
//  TabBarViewController.m
//  angelslike
//
//  Created by ridchan on 15/8/6.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import "TabBarViewController.h"

@interface TabBarViewController ()

@end

@implementation TabBarViewController

- (void)viewDidAppear:(BOOL)animated{
    static BOOL hasLoaded = NO;
    if (!hasLoaded) {
//        isHome = YES;
        [[NSNotificationCenter defaultCenter] removeObserver:self name:@"hideCustomTabBar" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(hideCustomTabBar)
                                                     name: @"hideCustomTabBar"
                                                   object: nil];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:@"bringCustomTabBarToFront" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(bringCustomTabBarToFront)
                                                     name: @"bringCustomTabBarToFront"
                                                   object: nil];
        
        
        [self hideRealTabBar];
        tabbar = [[MainTabBar alloc]init];
        [tabbar addTarget:self action:@selector(customerTabBarClick:)];
        
        [self bringCustomTabBarToFront];
        hasLoaded = YES;
    }
    [super viewDidAppear:animated];
    
}

-(void)setSelectedIndex:(NSUInteger)selectedIndex{
    [super setSelectedIndex:selectedIndex];
}

-(void)customerTabBarClick:(NSNumber *)number{
    [self setSelectedIndex:[number integerValue]];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
}


//隐藏真实tabbar
- (void)hideRealTabBar{
    
    for(UIView *view in self.view.subviews){
        if([view isKindOfClass:[UITabBar class]]){
            view.hidden = YES;
            break;
        }
    }
}





//将自定义的tabbar显示出来
- (void)bringCustomTabBarToFront{
    [self performSelector:@selector(hideRealTabBar)];
//    if (isHome) {
//        [self customTabBar];
//    }
    [UIView animateWithDuration:0.35 animations:^{
        tabbar.frame = CGRectMake(0, ScreenHeight - 49, ScreenWidth, 49);
        
    }];
}

//隐藏自定义tabbar
- (void)hideCustomTabBar{
    [self performSelector:@selector(hideRealTabBar)];
    [UIView animateWithDuration:0.35 animations:^{
        tabbar.frame = CGRectMake(0, ScreenHeight, ScreenWidth, 49);
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
