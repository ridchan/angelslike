//
//  CategoryViewController.h
//  angelslike
//
//  Created by angelslike on 15/8/6.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import "BaseViewController.h"
#import "LoadMoreTableView.h"
#import "CategoryCell.h"
#import "ThemeViewController.h"

@interface CategoryViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>

@property (strong,nonatomic) LoadMoreTableView *tableView;
@property (strong,nonatomic) NSDictionary *infos;
@property (strong,nonatomic) ThemeViewController *tvc;

@end
