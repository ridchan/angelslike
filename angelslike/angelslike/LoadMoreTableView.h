//
//  LoadMoreTableView.h
//  angelslike
//
//  Created by angelslike on 15/8/5.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeaderDefiner.h"

@interface LoadMoreTableView : UITableView<UIScrollViewDelegate>{
    id tar;
    SEL act;
}

@property(nonatomic) NSInteger currentPage;
@property(nonatomic) NSInteger totalPage;
@property(nonatomic) BOOL bLoading;

-(void)addTarget:(id)target action:(SEL)action;
-(void) loadDataEnd;
-(void) loadDataBegin;

@end
