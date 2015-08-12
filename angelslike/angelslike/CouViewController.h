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
#import "MXPullDownMenu.h"
#import "CouDetailViewController.h"

@interface CouViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,MXPullDownMenuDelegate,UISearchBarDelegate>{
    MXPullDownMenu *downMenu;
    UISearchBar *_searchBar;
    UISegmentedControl *seg;
    UISearchDisplayController *searchDisplayController;
}

@property (strong,nonatomic) LoadMoreTableView *tableView;
@property (strong,nonatomic) NSMutableArray *result;
@property (strong,nonatomic) NSString *cdn;
@property (strong,nonatomic) NSMutableDictionary *searchInfo;

@end
