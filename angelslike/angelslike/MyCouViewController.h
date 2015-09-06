//
//  MyCouViewController.h
//  angelslike
//
//  Created by angelslike on 15/8/28.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import "BaseViewController.h"
#import "LoadMoreTableView.h"
#import "CouCell.h"
#import "SearchViewController.h"
#import "MXPullDownMenu.h"
#import "CouDetailViewController.h"
#import "MJRefresh.h"
#import "AddressViewController.h"

typedef enum{
    CouViewTypeFromCou = 0,
    CouViewTypeFromSetting = 1,
}CouViewType;

@interface MyCouViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,MXPullDownMenuDelegate,UITextFieldDelegate,CouCellDelegate>{
    MXPullDownMenu *downMenu;
    UISearchBar *_searchBar;
    UISegmentedControl *seg;
    UISearchDisplayController *searchDisplayController;
    UINavigationBar *_navBar;
    UITextField *_textField;
}

@property (nonatomic) CouViewType ctype;
@property (strong,nonatomic) LoadMoreTableView *tableView;
@property (strong,nonatomic) NSMutableArray *result;
@property (strong,nonatomic) NSString *cdn;
@property (strong,nonatomic) NSMutableDictionary *searchInfo;
-(void)loadMoreData:(id)obj;
@end
