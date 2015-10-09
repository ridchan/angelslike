//
//  BuyOneDetailViewController.h
//  angelslike
//
//  Created by angelslike on 15/10/9.
//  Copyright © 2015年 angelslike. All rights reserved.
//

#import "BaseViewController.h"
#import "RCWebView.h"
#import "BuyOneDetailView.h"

@interface BuyOneDetailViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>{
    UIScrollView *_scrollView;
    __block UIImageView *tempCover;
}

@property(nonatomic,strong) NSDictionary *info;
@property(nonatomic,strong) NSString *strid;
@property(nonatomic,strong) UITableView *tableView;

@end
