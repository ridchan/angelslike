//
//  MainTabBar.h
//  angelslike
//
//  Created by angelslike on 15/8/5.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeaderDefiner.h"
#import "UIImage+RTTint.h"
#import "UIColor+HexColor.h"

@interface MTabBarItem : UIView

@property(nonatomic) BOOL canSelected;

-(void)setTitle:(NSString *)title image:(UIImage *)image;

-(void)setColor:(UIColor *)color;


@end

@interface MainTabBar : UIView{

}

@property (nonatomic) NSInteger selectIndex;
@property (nonatomic) NSInteger lastIndex;


@end
