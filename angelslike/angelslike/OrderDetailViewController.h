//
//  OrderDetailViewController.h
//  angelslike
//
//  Created by angelslike on 15/9/16.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import "BaseViewController.h"

@interface OrderDetailViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong) UITableView *tableView;

@property(nonatomic,strong) NSArray *result;

@property(nonatomic,strong) NSDictionary *info;

@property(nonatomic,strong) NSString *orderid;

@end
