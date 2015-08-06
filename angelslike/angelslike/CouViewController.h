//
//  CouViewController.h
//  angelslike
//
//  Created by ridchan on 15/8/6.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "LoadMoreTableView.h"
#import "CouCell.h"
#import "SearchViewController.h"

@interface CouViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>

@property (strong,nonatomic) LoadMoreTableView *tableView;
@property (strong,nonatomic) NSMutableArray *result;
@property (strong,nonatomic) NSString *cdn;

@end
