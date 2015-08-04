//
//  MainViewController.m
//  angelslike
//
//  Created by angelslike on 15/8/4.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initailSetting];
    __block MainViewController *tempSelf = self;

    [[NetWork shared] startQuery:@"http://www.angelslike.com/json/getList" info:@{@"type":@"list_theme",@"page":@"1",@"sort":@"new"} completeBlock:^(id Obj) {
        NSArray *rs = [[Obj objectForKey:@"data"] objectForKey:@"list"];
        tempSelf.cdn = [Obj objectForKey:@"cdn"];
        if ([rs count] > 0){
            [tempSelf.result addObjectsFromArray:rs];
            [tempSelf.tableView reloadData];
        }
    }];

    // Do any additional setup after loading the view.
}

-(void)initailSetting{
    self.result = [NSMutableArray array];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark -
#pragma mark table view method

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identify = @"Cell";
    MainCell *cell = [[MainCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    
    NSDictionary *info = [self.result objectAtIndex:indexPath.row];
    NSString *link = [self.cdn stringByAppendingPathComponent:[info objectForKey:@"img"]];
    [cell setImageView:link];
    [cell setName:[info objectForKey:@"title"]];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.result count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150;
}


@end
