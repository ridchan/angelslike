//
//  CouViewController.m
//  angelslike
//
//  Created by ridchan on 15/8/6.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import "CouViewController.h"

@interface CouViewController ()

@end

@implementation CouViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    [self initialSetting];
    [self loadMoreData:nil];
    // Do any additional setup after loading the view.
}

-(void)initialSetting{
    //顶部配置
    UISegmentedControl *seg = [[UISegmentedControl alloc]initWithItems:@[@"谁在凑分子",@"我的凑分子"]];
    seg.tintColor = [UIColor whiteColor];
    seg.selectedSegmentIndex = 0;
    self.navigationItem.titleView = seg;
    
    //搜索按钮
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(searchClick:)];
    barButtonItem.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = barButtonItem;
    


    self.result = [NSMutableArray array];
    self.tableView = [[LoadMoreTableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.currentPage = 0;
    self.tableView.totalPage = 0;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.tableView addTarget:self action:@selector(loadMoreData:)];
    [self.view addSubview:self.tableView];
        
 
}


-(void)loadMoreData:(id)obj{
    __block CouViewController *tempSelf = self;
    NSString *nPage = [NSString stringWithFormat:@"%ld",self.tableView.currentPage + 1];
    [[NetWork shared] startQuery:ListLink
                            info:@{@"type":@"list_cou",@"page":nPage,@"sort":@"new"}
                   completeBlock:^(id Obj) {
                       NSArray *rs = [[Obj objectForKey:@"data"] objectForKey:@"list"];
                       NSDictionary *pageInfo = [[Obj objectForKey:@"data"] objectForKey:@"pageinfo"];
                       tempSelf.cdn = [Obj objectForKey:@"cdn"];
                       if ([rs count] > 0){
                           tempSelf.tableView.totalPage = [[pageInfo objectForKey:@"maxpage"] integerValue];
                           tempSelf.tableView.currentPage = [[pageInfo objectForKey:@"page"] integerValue];
                           [tempSelf.result addObjectsFromArray:rs];
                           [tempSelf.tableView reloadData];
                       }
                       [tempSelf.tableView loadDataEnd];
                   }];
}

-(void)searchClick:(id)sender{
    SearchViewController *vc = [[SearchViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark -
#pragma mark table view method

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate

{
    
    // 下拉到最底部时显示更多数据
    
    if( scrollView.contentOffset.y > ((scrollView.contentSize.height - scrollView.frame.size.height)))
    {
        [self.tableView loadDataBegin];
    }
    
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *identify = @"Cell";
    CouCell *cell = (CouCell *)[tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[CouCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        cell.backgroundColor =  [UIColor clearColor];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    
    cell.info = [self.result objectAtIndex:indexPath.row];
    
    return cell;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  [self.result count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 115 + CouCellGap;
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

@end
