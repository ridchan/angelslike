//
//  MineViewController.h
//  angelslike
//
//  Created by angelslike on 15/8/7.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import "BaseViewController.h"
#import "MineCell.h"

@interface MineViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>


@property(nonatomic,strong) UITableView *tableView;

@property(nonatomic,strong) NSArray *infos;

@end