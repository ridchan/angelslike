//
//  CommentAllViewController.h
//  angelslike
//
//  Created by angelslike on 15/9/14.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import "BaseViewController.h"
#import "LoadMoreTableView.h"
#import "MJRefresh.h"
#import "CommentCell.h"
#import "AnswerView.h"
#import "CommentAllViewController.h"
#import "SubCommentCell.h"

@interface CommentAllViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>{
    AnswerView *anView;
    NSString *commentType;
    BOOL viewisAppear;
}

@property(nonatomic,strong) UITableViewCell *headerCell;
@property(nonatomic,strong) NSDictionary *info;
@property(nonatomic,strong) NSMutableArray *result;
@property(nonatomic,strong) LoadMoreTableView *tableView;
@property(nonatomic,strong) NSMutableDictionary *heights;

@end
