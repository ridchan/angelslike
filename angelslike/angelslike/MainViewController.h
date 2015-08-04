//
//  MainViewController.h
//  angelslike
//
//  Created by angelslike on 15/8/4.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "NetWork.h"
#import "MainCell.h"
#import "HeaderDefiner.h"

@interface MainViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (strong,nonatomic) UITableView *tableView;
@property (strong,nonatomic) NSMutableArray *result;
@property (strong,nonatomic) NSString *cdn;

@end
