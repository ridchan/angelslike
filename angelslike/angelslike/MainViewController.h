//
//  MainViewController.h
//  angelslike
//
//  Created by angelslike on 15/8/4.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "NetWork.h"
#import "MainCell.h"
#import "ImageScroller.h"
#import "LoadMoreTableView.h"
#import "HeaderDefiner.h"
#import "Banner.h"


@interface MainViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    ImageScroller *scroller;
    Banner *banner;
    CGFloat scrolerHeight ;
    CGFloat cellHeight;
}

@property (strong,nonatomic) LoadMoreTableView *tableView;
@property (strong,nonatomic) NSMutableArray *result;
@property (strong,nonatomic) NSString *cdn;

@end
