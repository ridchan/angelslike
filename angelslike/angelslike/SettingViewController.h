//
//  SettingViewController.h
//  angelslike
//
//  Created by angelslike on 15/8/13.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import "BaseViewController.h"
#import "MineCell.h"
#import "AbountUsViewController.h"

@interface SettingViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>

@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) NSArray *infos;


@end
