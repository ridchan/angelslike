//
//  OrderListViewController.h
//  angelslike
//
//  Created by angelslike on 15/9/9.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import "BaseViewController.h"
#import "LoadMoreTableView.h"
#import "MXPullDownMenu.h"
#import "MJRefresh.h"
#import "OrderViewCell.h"
#import "OrderDetailViewController.h"
#import "WeiXinPayObj.h"

@interface OrderListViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource,MXPullDownMenuDelegate>{
    CGFloat cellHeight;
    MXPullDownMenu *downMenu;
}

@property(nonatomic,strong) LoadMoreTableView *tableView;
@property(nonatomic,strong) NSMutableArray *result;
@property(nonatomic,strong) NSString *cdn;
@property (strong,nonatomic) NSMutableDictionary *searchInfo;

@end
