//
//  PayRecordsViewController.h
//  angelslike
//
//  Created by angelslike on 15/9/15.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import "BaseViewController.h"
#import "LoadMoreTableView.h"
#import "PayRecordCell.h"

@interface PayRecordsViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>{
    
}
@property (strong,nonatomic) LoadMoreTableView *tableView;
@property (strong,nonatomic) NSMutableArray *result;

@end

