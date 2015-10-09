//
//  BuyOneViewController.h
//  angelslike
//
//  Created by angelslike on 15/10/9.
//  Copyright © 2015年 angelslike. All rights reserved.
//

#import "BaseViewController.h"
#import "LoadMoreTableView.h"
#import "BuyOneCell.h"
#import "MJRefresh.h"
#import "BuyOneDetailViewController.h"


@interface BuyOneViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>


@property (strong,nonatomic) LoadMoreTableView *tableView;
@property (strong,nonatomic) NSMutableArray *result;

@end
