//
//  CommentViewController.h
//  angelslike
//
//  Created by angelslike on 15/8/25.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import "BaseViewController.h"
#import "LoadMoreTableView.h"
#import "MJRefresh.h"
#import "CommentCell.h"

@interface CommentViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong) LoadMoreTableView *tableView;
@property(nonatomic,strong) NSMutableArray *result;

@property(nonatomic,strong) NSDictionary *info;

@end
