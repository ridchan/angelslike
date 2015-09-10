//
//  ThemeDetailViewController.h
//  angelslike
//
//  Created by angelslike on 15/8/27.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import "BaseViewController.h"
#import "TopCell.h"
#import "ItemCell.h"
#import "ProductDetailViewController.h"
#import "BottomView.h"
#import "CommentViewController.h"

@interface ThemeDetailViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,ItemCellDelegate>{
    BottomView *bv;
}


@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) NSDictionary *result;
@property(nonatomic,strong) NSString *strid;
@property(nonatomic,strong) NSMutableDictionary *indexs;

@end
