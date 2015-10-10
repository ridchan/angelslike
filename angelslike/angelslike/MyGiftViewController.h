//
//  MyGiftViewController.h
//  angelslike
//
//  Created by angelslike on 15/10/10.
//  Copyright © 2015年 angelslike. All rights reserved.
//

#import "BaseViewController.h"
#import "LoadMoreTableView.h"
#import "MXPullDownMenu.h"
#import "MJRefresh.h"
#import "MyGiftCell.h"

@interface MyGiftViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>{
    MXPullDownMenu *downMenu;
    UISegmentedControl *seg;
}

@property (strong,nonatomic) LoadMoreTableView *tableView;
@property (strong,nonatomic) NSMutableArray *result;
@property (strong,nonatomic) NSMutableDictionary *searchInfo;

@end
