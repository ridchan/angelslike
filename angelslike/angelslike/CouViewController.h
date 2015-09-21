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
#import "MJRefresh.h"
#import "MyCouViewController.h"
#import "LoginViewController.h"

@interface CouViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,MXPullDownMenuDelegate,UITextFieldDelegate,UISearchBarDelegate>{
    MXPullDownMenu *downMenu;
    UISearchBar *_searchBar;
    UISegmentedControl *seg;
    UISearchDisplayController *searchDisplayController;
    UINavigationBar *_navBar;
    UITextField *_textField;
}

@property (strong,nonatomic) LoadMoreTableView *tableView;
@property (strong,nonatomic) NSMutableArray *result;
@property (strong,nonatomic) NSString *cdn;
@property (strong,nonatomic) NSMutableDictionary *searchInfo;
@property (strong,nonatomic) MyCouViewController *mvc;

@end
