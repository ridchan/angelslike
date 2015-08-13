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
                     ],
                   @[@{@"Name":@"退出登陆",@"IMG":@"iconfont-jilu"},
                     ]
                   ];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    [self.tableView reloadData];
    

    
}

-(void)logoutClick:(id)sender{
    
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
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
//            [logoutButton setTitleColor:[UIColor getHexColor:@"F85C85"] forState:UIControlStateNormal];
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
