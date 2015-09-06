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


-(void)viewDidLoad{
    [super viewDidLoad];
}

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
        tabbar.delegate = self;

        
        if ([UserInfo shared].loadGuide) {
            GuideViewController *gvc = [[GuideViewController alloc]init];
            [self presentViewController:gvc animated:NO completion:NULL];
        }
        
        hasLoaded = YES;
    }
    
    
    [self performSelector:@selector(hideRealTabBar)];
    [self bringCustomTabBarToFront];
    
    [super viewDidAppear:animated];
    
    
}

-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    NSInteger idx = [navigationController.viewControllers indexOfObject:viewController];
    if (idx == 0) {
        [self bringCustomTabBarToFront];
    }else if (idx == 1){
//        viewController.hidesBottomBarWhenPushed = YES;
        [self hideCustomTabBar];
    }
}



-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self hideCustomTabBar];
}

-(BOOL)tabbarShouldTap:(MTabBarItem *)item atIndex:(NSInteger)index{
    if (index == 2) {
        return NO;
    }else if(index == 4 & [UserInfo shared].info == nil){
        LoginViewController *lvc = [[LoginViewController alloc]init];
        lvc.bvc = self;
        UINavigationController *nvc = [[UINavigationController alloc]initWithRootViewController:lvc];
        [self presentViewController:nvc animated:YES completion:NULL];
        return NO;
    }
    return YES;
}

-(void)tabbarTap:(MTabBarItem *)item atIndex:(NSInteger)index{
    [self setSelectedIndex:index];
}

-(void)setSelectedIndex:(NSUInteger)selectedIndex{
    [tabbar setSelectIndex:selectedIndex];
    [super setSelectedIndex:selectedIndex];
}




- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
}


//隐藏真实tabbar
- (void)hideRealTabBar{
    self.tabBar.hidden = YES;
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
    [UIView animateWithDuration:.35 animations:^{
        tabbar.frame = CGRectMake(0, ScreenHeight - 49, ScreenWidth, 49);
        
    }];
}

//隐藏自定义tabbar
- (void)hideCustomTabBar{
    [self performSelector:@selector(hideRealTabBar)];
    [UIView animateWithDuration:.35 animations:^{
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
