//
//  CategoryViewController.m
//  angelslike
//
//  Created by angelslike on 15/8/6.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import "CategoryViewController.h"

@implementation CategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initialSetting];
    // Do any additional setup after loading the view.
}



-(void)initialSetting{
    
    
    //table view
    self.tableView = [[LoadMoreTableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.currentPage = 0;
    self.tableView.totalPage = 0;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.tableView];
    [self.tableView reloadData];
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identify = @"Cell";
    CategoryCell *cell = (CategoryCell *)[tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[CategoryCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        cell.backgroundColor =  [UIColor clearColor];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    cell.title = @"对象";
    cell.buttonInfos = @[@{@"Name":@"送长辈",@"IMG":@"duixiang_00.png"},
                         @{@"Name":@"送恋人",@"IMG":@"duixiang_01.png"},
                         @{@"Name":@"送同事",@"IMG":@"duixiang_02.png"},
                         @{@"Name":@"送朋友",@"IMG":@"duixiang_03.png"},
                         @{@"Name":@"送老师",@"IMG":@"duixiang_04.png"},
                         @{@"Name":@"送儿童",@"IMG":@"duixiang_05.png"},
                         @{@"Name":@"送亲人",@"IMG":@"duixiang_06.png"},
                         @{@"Name":@"送嘉宾",@"IMG":@"duixiang_07.png"}
                         ];
    
    return cell;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}

@end
