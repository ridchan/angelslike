//
//  LoadMoreTableView.m
//  angelslike
//
//  Created by angelslike on 15/8/5.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import "LoadMoreTableView.h"

@implementation LoadMoreTableView

@synthesize currentPage = _currentPage , totalPage = _totalPage;

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    if (self =  [super initWithFrame:frame style:style]) {
        [self setReloadHeader];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setReloadHeader];
    }
    return self;
}

-(void)addTarget:(id)target action:(SEL)action{
    tar = target;
    act = action;
}

-(void)setCurrentPage:(NSInteger)currentPage{
    _currentPage = currentPage;
    [self createTableFooter];
}

-(void)setTotalPage:(NSInteger)totalPage{
    _totalPage = totalPage;
    [self createTableFooter];
}

-(void)setReloadHeader{
    hub = [[RCHub alloc]initWithFrame:CGRectMake(0, -44, ScreenWidth, 30)];
    hub.tag = 9999;
    [self addSubview:hub];
    
    [self addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    [self.panGestureRecognizer addObserver:self forKeyPath:@"state" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
//    NSLog(@"keypath : %@ \n value: %@" ,keyPath,change);
    static float offset = 0;
    static int type = 0;
    if ([keyPath isEqualToString:@"state"]) {
        NSLog(@"%@",change);
        type = [[change objectForKey:@"new"] intValue];
        int oldtype = [[change objectForKey:@"old"] intValue];
        if (oldtype != type & type == 3) {
            if (offset < -108) {
                [hub startAnimation];
            }
        }
    }
    if ([keyPath isEqualToString:@"contentOffset"]) {
        offset = [[change objectForKey:@"new"] CGPointValue].y;
    }
}


- (void) createTableFooter

{
    
    self.tableFooterView = nil;

    if (_currentPage < _totalPage) {
        UIView *tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.bounds.size.width, 40.0f)];
        
        UILabel *loadMoreText = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 116.0f, 40.0f)];
        
        [loadMoreText setCenter:tableFooterView.center];
        
        [loadMoreText setFont:[UIFont fontWithName:@"Helvetica Neue" size:14]];
        
        [tableFooterView addSubview:loadMoreText];
        
        
        self.tableFooterView = tableFooterView;
    }
    

    
}





- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate

{
    
    // 下拉到最底部时显示更多数据
    
    if(!self.bLoading && scrollView.contentOffset.y >= ((scrollView.contentSize.height - scrollView.frame.size.height)))
    {
        [self loadDataBegin];
    }
    
    
}


- (void) loadDataBegin

{
    if(self.bLoading) return;
    
    if (self.bLoading == NO)
        
    {
        
        self.bLoading = YES;
        
        UIActivityIndicatorView *tableFooterActivityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(75.0f, 10.0f, 20.0f, 20.0f)];
        tableFooterActivityIndicator.center = CGPointMake(ScreenWidth / 2, 20);
        
        [tableFooterActivityIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
        
        [tableFooterActivityIndicator startAnimating];
        
        [self.tableFooterView addSubview:tableFooterActivityIndicator];
        
        
        if ([tar respondsToSelector:act]) {
            [tar performSelector:act withObject:nil];
        }
        
    }
}

-(void) loadDataEnd{
    self.bLoading = NO;
    
    [self createTableFooter];
}

@end
