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
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.x - ScreenWidth / 4 >  scrollView.contentSize.width - scrollView.frame.size.width) {
        [self dismissViewControllerAnimated:NO completion:NULL];
    }
}

@end
