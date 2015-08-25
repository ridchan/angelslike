//
//  SettingViewController.m
//  angelslike
//
//  Created by angelslike on 15/8/13.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import "SettingViewController.h"

@implementation SettingViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    [self initialSetting];
}


-(void)initialSetting{
    
    self.navigationItem.title = @"设置";
    
    self.infos = @[@[@{@"Name":@"天使礼客",@"IMG":@"iconfont-jilu"},
                     @{@"Name":@"APP下载",@"IMG":@"iconfont-woyaotixian"}
                     ]
                   ];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.scrollEnabled = NO;
    [self.view addSubview:self.tableView];
    [self.tableView reloadData];
    
    [self addLogoutButton];
    

    
}

-(void)addLogoutButton{
    RCRoundButton *logoutButton = [RCRoundButton buttonWithType:UIButtonTypeCustom];
    logoutButton.frame = CGRectMake(10, 124, ScreenWidth - 20, 35);
    [logoutButton setTitle:@"退出登录" forState:UIControlStateNormal];
    [logoutButton setBackgroundColor:[UIColor getHexColor:@"F85C85"]];
    [logoutButton addTarget:self action:@selector(logoutClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.tableView addSubview:logoutButton];
}

-(void)logoutClick:(id)sender{
    [UserInfo shared].info = nil;
    [self.navigationController popViewControllerAnimated:YES];
    [self.navigationController.tabBarController setSelectedIndex:0];
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.1;
    }else{
        return 20;
    }
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        static NSString *identify = @"Cell";
        MineCell *cell = (MineCell *) [tableView dequeueReusableCellWithIdentifier:identify];
        if (cell == nil) {
            cell = [[MineCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        }
        NSDictionary *info = [[self.infos objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        cell.info = info;
        
        return cell;
    }else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"logoutButton"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"logoutButton"];
            cell.backgroundColor = [UIColor clearColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            RCRoundButton *logoutButton = [RCRoundButton buttonWithType:UIButtonTypeCustom];
            logoutButton.frame = CGRectMake(10, 4, ScreenWidth - 20, 35);
            [logoutButton setTitle:@"退出登录" forState:UIControlStateNormal];
            [logoutButton setBackgroundColor:[UIColor getHexColor:@"F85C85"]];
            [logoutButton addTarget:self action:@selector(logoutClick:) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:logoutButton];
        }
        
        return cell;
    }


    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  [[self.infos objectAtIndex:section] count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.infos count];
}

@end
