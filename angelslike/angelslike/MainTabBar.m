//
//  MainTabBar.m
//  angelslike
//
//  Created by angelslike on 15/8/5.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import "MainTabBar.h"

#define BarHeight 49


@implementation MTabBarItem

-(void)setTitle:(NSString *)title image:(UIImage *)image{
    //图片
    UIImageView *imageView = (UIImageView *) [self viewWithTag:1];
    if (!imageView) {
        imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 5 , 25, 25)];
        imageView.userInteractionEnabled = NO;
        imageView.tag =  1;
        [self addSubview:imageView];
    }
    
    if ([title length] == 0) {
        self.canSelected = NO;
        imageView.frame = CGRectMake(0, 0 ,35, 35);
        imageView.center = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
        imageView.image = image;
        self.backgroundColor =  [UIColor getHexColor:@"ff6969"];
    }else {
        imageView.image = [image rt_tintedImageWithColor:[UIColor getHexColor:@"8A8A8A"]];
        imageView.center = CGPointMake(self.frame.size.width / 2, imageView.center.y);
    }
    //标题
    UILabel *label  = (UILabel *)[self viewWithTag:2];
    if (!label) {
        label = [[UILabel alloc]initWithFrame:CGRectMake(0, 30, self.frame.size.width, 18)];
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont systemFontOfSize:12];
        label.textColor = [UIColor getHexColor:@"8A8A8A"];
        label.tag = 2;
        [self addSubview:label];
    }
    label.text = title;
    label.center = CGPointMake(self.frame.size.width / 2, label.center.y);
}


-(void)setColor:(UIColor *)color{
    UIImageView *imageView = (UIImageView *) [self viewWithTag:1];
    UILabel *label  = (UILabel *)[self viewWithTag:2];
    
    imageView.image = [imageView.image rt_tintedImageWithColor:color];
    label.textColor =  color;
}

- (instancetype)init{
    if (self = [super init]) {
        self.canSelected = YES;
    }
    return self;
}


@end

#define indexOffset 101

@implementation MainTabBar


@synthesize selectIndex = _selectIndex;

-(void)tabItemClick:(UITapGestureRecognizer *)recognizer{
    MTabBarItem *item = (MTabBarItem *)recognizer.view;
    if (item.canSelected == NO) return;
    if (item.tag - indexOffset != self.selectIndex) {
        MTabBarItem *lastItem = (MTabBarItem *)[self viewWithTag:self.selectIndex + indexOffset];
        [lastItem setColor:[UIColor getHexColor:@"8A8A8A"]];

        self.selectIndex = item.tag - indexOffset;
    }
}

-(void)setSelectIndex:(NSInteger)selectIndex{
    _selectIndex = selectIndex;
    
    MTabBarItem *item = (MTabBarItem *)[self viewWithTag:selectIndex + indexOffset];
    [item setColor:[UIColor getHexColor:@"ff6969"]];
}

-(instancetype)init{
    if (self = [super init]) {
        self.frame = CGRectMake(0, ScreenHeight - BarHeight, ScreenWidth, BarHeight);
        UIWindow *window = nil;
        id<UIApplicationDelegate> delegate = [[UIApplication sharedApplication] delegate];
        if ([delegate respondsToSelector:@selector(window)])
            window = [delegate performSelector:@selector(window)];
        else window = [[UIApplication sharedApplication] keyWindow];
        [window addSubview:self];
        [self initialSetting];
    }
    return self;
}

-(void)initialSetting{

    
    CGFloat buttonWidht = ScreenWidth / 5;
    NSArray *infos = @[@{@"Name":@"首页",@"IMG":@"iconfont-shouye"},
                      @{@"Name":@"凑分子",@"IMG":@"iconfont-cfz"},
                      @{@"Name":@"",@"IMG":@"iconfont-jia"},
                      @{@"Name":@"分类",@"IMG":@"iconfont-fenlei"},
                      @{@"Name":@"我的",@"IMG":@"iconfont-wode"}
                      ];
    for (int i = 0 ; i < 5 ; i ++){
        NSDictionary *info = [infos objectAtIndex:i];
        //建立 TabBarItem
        MTabBarItem *item =  [[MTabBarItem alloc]init];
        item.frame = CGRectMake(i * buttonWidht, 0, buttonWidht, BarHeight);
        item.tag = i  + indexOffset;
        [item setTitle:[info objectForKey:@"Name"] image:[UIImage imageNamed:[info objectForKey:@"IMG"]]];
        //添加 点击 手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tabItemClick:)];
        [item addGestureRecognizer:tap];
        [self addSubview:item];
    }
    self.selectIndex = 0;
}

@end
