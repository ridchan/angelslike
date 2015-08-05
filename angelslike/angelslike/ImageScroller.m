//
//  ImageScroller.m
//  angelslike
//
//  Created by angelslike on 15/8/4.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import "ImageScroller.h"



@implementation DotPageControl

-(void)initial{
    UIGraphicsBeginImageContext(CGSizeMake(40, 40));
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 2.0);
    CGContextStrokeEllipseInRect(context, CGRectMake(0, 0, 40, 40));
    _activeImage = UIGraphicsGetImageFromCurrentImageContext();
    
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self =  [super initWithFrame:frame]) {
        [self initial];
    }
    return self;
}


- (void)updateDots
{
//    for (int i = 0; i< [self.subviews count]; i++) {
//        UIView* dot = [self.subviews objectAtIndex:i];
//        [dot.layer ]
//            if (i == self.currentPage){
//                dot.image = _activeImage;
//            }
//            else
//                dot.image = _inactiveImage;
//        }
//
//    }
}

- (void)setCurrentPage:(NSInteger)currentPage
{
    [super setCurrentPage:currentPage];
    [self updateDots];
}

@end

@implementation ImageScroller


-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        [self addSubview:_scrollView];
        
        _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, frame.size.height / 5 * 4, frame.size.width, frame.size.height / 5)];
        _pageControl.hidesForSinglePage = YES;
        _pageControl.currentPageIndicatorTintColor = [UIColor colorWithPatternImage:[self dotImage]];
        _pageControl.pageIndicatorTintColor =  [UIColor whiteColor];
        tar = nil;
        [self addSubview:_pageControl];
        
    }
    
    return self;
}

-(UIImage *)dotImage{
    UIGraphicsBeginImageContext(CGSizeMake(7, 7));
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextSetLineWidth(context, 2.0);
    CGContextStrokeEllipseInRect(context, CGRectMake(0, 0, 7, 7));
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    return image;
    
}

// 图片自动循环

-(void)runBanner{
    [_scrollView scrollRectToVisible:CGRectMake(_scrollView.frame.size.width + _scrollView.contentOffset.x , 0, _scrollView.frame.size.width, _scrollView.frame.size.height) animated:YES];
    [self scrollViewDidEndDecelerating:_scrollView];
}

//按连接获取循环图片数据

-(void)start:(NSString *)link{
    __block ImageScroller *tempSelf = self;
    NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:link]];


    [NSURLConnection sendAsynchronousRequest:request queue:[[NetWork shared]GetQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        dispatch_async(dispatch_get_main_queue(), ^{
            id obj = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            if (obj) {
                tempSelf.cdn = [obj objectForKey:@"cdn"];
                tempSelf.infos = [obj objectForKey:@"data"];
                [tempSelf startDownload];
            }
        });
        
        
    }];
}

//按数据设置图片

-(void)startDownload{
    if ([self.infos count] > 0) {
        NSMutableArray * nArr = [NSMutableArray arrayWithArray:self.infos];
        [nArr insertObject:[self.infos objectAtIndex:[self.infos count] - 1] atIndex:0];
        [nArr addObject:[self.infos objectAtIndex:0]];
        
        self.infos = [NSArray arrayWithArray:nArr];
        
        for (int i = 0 ; i < [self.infos count] ;  i ++){
            NSDictionary *info  = [self.infos objectAtIndex:i];
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width * i, 0, self.frame.size.width, self.frame.size.height)];
            imageView.userInteractionEnabled = YES;
            imageView.tag = i + 1;
            [_scrollView addSubview:imageView];
            
            [imageView sd_setImageWithURL:[NSURL URLWithString:[[NSString stringWithFormat:@"http://%@",self.cdn] stringByAppendingPathComponent:[info objectForKey:@"img"]]]];
            
            UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageViewTap:)];
            [imageView addGestureRecognizer:recognizer];
        }


        
        _pageControl.numberOfPages = [self.infos count] - 2;
        _scrollView.contentSize = CGSizeMake(self.frame.size.width * [self.infos count], 1);
        [_scrollView scrollRectToVisible:CGRectMake(_scrollView.frame.size.width , 0, _scrollView.frame.size.width, _scrollView.frame.size.height) animated:NO];
        
        [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(runBanner) userInfo:nil repeats:YES];
    }
    

    
}

//图片点击

-(void)imageViewTap:(UITapGestureRecognizer *)recognizer{
    UIImageView *imageView = (UIImageView *)recognizer.view;
    NSDictionary *info = [self.infos objectAtIndex:imageView.tag - 1];
    if ([tar respondsToSelector:sel])
        [tar performSelector:sel withObject:info];
}


//监听点击调用事件

-(void)addTarget:(id)target selector:(SEL)selector{
    tar = target;
    sel = selector;
}


#pragma mark -

// delegate 委托事件

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSInteger idx = lrintf(scrollView.contentOffset.x / scrollView.frame.size.width);
    if (idx == 0) {
        _pageControl.currentPage = _pageControl.numberOfPages + 1;
    }else if (idx == _pageControl.numberOfPages + 1){
        _pageControl.currentPage = 0;
    }else{
        _pageControl.currentPage = idx - 1;
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger idx = lrintf(scrollView.contentOffset.x / scrollView.frame.size.width);
    CGRect rect = CGRectZero;
    rect.size = _scrollView.frame.size;
    if (idx == 0) {
        rect.origin = CGPointMake(_scrollView.contentSize.width - _scrollView.frame.size.width * 2, 0);
        [scrollView scrollRectToVisible:rect animated:NO];
    }else if (idx == _pageControl.numberOfPages + 1){
        rect.origin = CGPointMake(_scrollView.frame.size.width, 0);
        [scrollView scrollRectToVisible:rect animated:NO];
    }
    
}


@end
