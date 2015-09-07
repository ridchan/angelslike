//
//  CouRecordsViewController.h
//  angelslike
//
//  Created by angelslike on 15/9/7.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import "BaseViewController.h"
#import "LoadMoreTableView.h"
#import "MJRefresh.h"
#import "CouRecrodCell.h"

@interface CouRecordsViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong) LoadMoreTableView *tableView;
@property(nonatomic,strong) NSMutableArray *result;

@property(nonatomic,strong) NSDictionary *info;
@property(nonatomic,strong) NSMutableDictionary *heights;

@end
