//
//  GuideViewController.m
//  angelslike
//
//  Created by angelslike on 15/8/11.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import "GuideViewController.h"

@implementation GuideViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    
//    self.view.backgroundColor = [UIColor clearColor];
    NSArray *pages = @[@"01-引导页.jpg",@"02-引导页.jpg",@"03-引导页.jpg"];
    
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.delegate = self;
//    scrollView.backgroundColor = [UIColor clearColor];
    for (int i = 0 ; i < [pages count] ; i ++){
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth * i, 0, ScreenWidth, ScreenHeight)];
        imageView.image = [UIImage imageNamed:[pages objectAtIndex:i]];
        [scrollView addSubview:imageView];
    }
    scrollView.contentSize = CGSizeMake(ScreenWidth * [pages count], 1);
    
    [self.view addSubview:scrollView];
    
    skipButton = [UIButton buttonWithType:UIButtonTypeCustom];
    skipButton.frame = CGRectMake((ScreenWidth - 80) / 2 , ScreenHeight - 120, 80, 30);
    [skipButton setTitle:@"立即体验" forState:UIControlStateNormal];
    [skipButton setTitleColor:[UIColor getHexColor:@"F88F19"] forState:UIControlStateNormal];
    [skipButton addTarget:self action:@selector(skipNext:) forControlEvents:UIControlEventTouchUpInside];
    skipButton.layer.borderWidth = 1;
    skipButton.layer.masksToBounds = YES;
    skipButton.layer.cornerRadius = 3;
    skipButton.layer.borderColor = [UIColor getHexColor:@"F88F19"].CGColor;
    skipButton.hidden = YES;
    [self.view addSubview:skipButton];
}

-(void)skipNext:(id)sender{
    [self dismissViewControllerAnimated:NO completion:NULL];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.x < scrollView.contentSize.width - scrollView.frame.size.width) {
        skipButton.hidden = YES;

    }else{
        skipButton.hidden = NO;

    }

}

@end
