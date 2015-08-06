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

@interface CategoryViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>

@property (strong,nonatomic) LoadMoreTableView *tableView;

@end
