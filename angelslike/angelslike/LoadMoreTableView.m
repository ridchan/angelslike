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


- (void) createTableFooter

{
    
    self.tableFooterView = nil;

    if (_currentPage < _totalPage) {
        UIView *tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.bounds.size.width, 40.0f)];
        
        UILabel *loadMoreText = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 116.0f, 40.0f)];
        
        [loadMoreText setCenter:tableFooterView.center];
        
        [loadMoreText setFont:[UIFont fontWithName:@"Helvetica Neue" size:14]];
        
        [loadMoreText setText:@"上拉显示更多数据"];
        
        [tableFooterView addSubview:loadMoreText];
        
        
        self.tableFooterView = tableFooterView;
    }
    

    
}



- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate

{
    
    // 下拉到最底部时显示更多数据
    
    if(!self.bLoading && scrollView.contentOffset.y > ((scrollView.contentSize.height - scrollView.frame.size.height)))
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
