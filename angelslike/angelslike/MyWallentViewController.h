//
//  MyWallentViewController.h
//  angelslike
//
//  Created by angelslike on 15/9/15.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import "BaseViewController.h"
#import "MineCell.h"
#import "AnswerView.h"

@interface MyWallentViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>


@property(nonatomic,strong) NSDictionary *info;
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) NSArray *infos;

@end
