//
//  MineViewController.m
//  angelslike
//
//  Created by angelslike on 15/8/7.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import "MineViewController.h"

@implementation MineViewController

@synthesize tableView = _tableView;



-(void)viewDidLoad{
    [super viewDidLoad];
    [self initialSetting];
}


-(void)initialSetting{
    
    self.navigationItem.title = @"我的";
    
    self.infos = @[@[@{@"Name":@"我的凑分子",@"IMG":@"mine_00"},
                     @{@"Name":@"我购买的礼物",@"IMG":@"mine_01"},
                     @{@"Name":@"我的关注",@"IMG":@"mine_02"}
                     ],
                   @[@{@"Name":@"达人专区",@"IMG":@"mine_03"},
                     @{@"Name":@"邀请朋友",@"IMG":@"mine_04"},
                     @{@"Name":@"设置",@"IMG":@"mine_05"}
                     ]
                   ];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    [self.tableView reloadData];
    
}

#pragma mark -
#pragma mark table view delegate

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identify = @"Cell";
    MineCell *cell = (MineCell *) [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[MineCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    NSDictionary *info = [[self.infos objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    cell.info = info;
    
    return cell;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  [[self.infos objectAtIndex:section] count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.infos count];
}


@end