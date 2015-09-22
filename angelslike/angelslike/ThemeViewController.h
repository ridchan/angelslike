//
//  ThemeViewController.h
//  angelslike
//
//  Created by angelslike on 15/8/7.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import "BaseViewController.h"
#import "LoadMoreTableView.h"
#import "MainCell.h"
#import "HeaderDefiner.h"
#import "MXPullDownMenu.h"
#import "MJRefresh.h"
#import "ThemeDetailViewController.h"

@interface ThemeViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource,MXPullDownMenuDelegate>{
    CGFloat cellHeight;
    MXPullDownMenu *downMenu;
}

@property(nonatomic,strong) LoadMoreTableView *tableView;
@property(nonatomic,strong) NSMutableArray *result;
@property(nonatomic,strong) NSString *cdn;
@property (strong,nonatomic) NSMutableDictionary *searchInfo;

-(void)reloadData;

@end
