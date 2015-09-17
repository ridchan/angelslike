//
//  ProductRecordViewController.h
//  angelslike
//
//  Created by angelslike on 15/9/17.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import "BaseViewController.h"
#import "LoadMoreTableView.h"
#import "HeaderDefiner.h"
#import "NetWork.h"
#import "ProductRecordCell.h"

@interface ProductRecordViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong) LoadMoreTableView *tableView;
@property(nonatomic,strong) NSMutableArray *result;
@property(nonatomic,strong) NSString *strid;
@property(nonatomic,strong) NSString *strurl;

@end
