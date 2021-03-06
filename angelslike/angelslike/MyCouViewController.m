//
//  MyCouViewController.m
//  angelslike
//
//  Created by angelslike on 15/8/28.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import "MyCouViewController.h"

@interface MyCouViewController ()

@end

@implementation MyCouViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self initialSetting];
    [self loadMoreData:nil];
    
    // Do any additional setup after loading the view.
}

-(void)initialSetting{
    
    
    self.searchInfo = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"list_cou",@"type",
                       @"new",@"sort",nil];
    
    self.navigationItem.title = @"我的凑分子";
    //顶部配置
//    seg = [[UISegmentedControl alloc]initWithItems:@[@"谁在凑分子",@"我的凑分子"]];
//    seg.frame = CGRectMake(0, 6 , 200, 32);
//    seg.tintColor = [UIColor whiteColor];
//    seg.selectedSegmentIndex = 0;
//    self.navigationItem.titleView = seg;
//    
//    //搜索按钮
//    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(searchClick:)];
//    barButtonItem.tintColor = [UIColor whiteColor];
//    self.navigationItem.rightBarButtonItem = barButtonItem;
    
    //搜索框
//    _navBar = [[UINavigationBar alloc]initWithFrame:CGRectMake(ScreenWidth, 0, ScreenWidth, 44)];
//    
//    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [backButton setTitle:@"返回" forState:UIControlStateNormal];
//    backButton.frame = CGRectMake(ScreenWidth - 60, 0, 50, 44);
//    [backButton addTarget:self action:@selector(backClick:) forControlEvents:UIControlEventTouchUpInside];
    
//    _textField = [[UITextField alloc]initWithFrame:CGRectMake(10, 8, ScreenWidth - 70 , 28)];
//    _textField.borderStyle = UITextBorderStyleRoundedRect;
//    _textField.returnKeyType = UIReturnKeySearch;
//    _textField.delegate = self;
//    _textField.placeholder  = @"搜索";
//    
//    [_navBar addSubview:_textField];
//    [_navBar addSubview:backButton];
//    
//    
//    
//    [self.navigationController.navigationBar addSubview:_navBar];
//    [self.navigationItem setHidesBackButton:YES];

    //table view
    self.result = [NSMutableArray array];
    if (self.ctype == CouViewTypeFromSetting) {
        self.tableView = [[LoadMoreTableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        self.tableView.contentInset = UIEdgeInsetsMake(44 , 0, 0, 0);
    }else{
        self.tableView = [[LoadMoreTableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 44)];
        self.tableView.contentInset = UIEdgeInsetsMake(104 , 0, 0, 0);
    }
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.currentPage = 0;
    self.tableView.totalPage = 0;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
    
    [self.tableView addTarget:self action:@selector(loadMoreData:)];
    [self.view addSubview:self.tableView];
    
    
    //pull down menu
    NSArray *nameArr;
    nameArr = @[ @[ @"全部类型", @"人情凑", @"颜值凑", @"爱心凑", @"随便凑"], @[@"全部状态", @"进行中" ,@"已完成"], @[@"按时间最新", @"按人气最高", @"按总价最贵"]];
    downMenu = [[MXPullDownMenu alloc] initWithArray:nameArr selectedColor:[UIColor getHexColor:@"FE6869"]];
    downMenu.delegate = self;
    downMenu.frame = CGRectMake(0, 64, ScreenWidth, 35);
    [self.view addSubview:downMenu];
    
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshClick:)];
    header.automaticallyChangeAlpha = YES;
    header.lastUpdatedTimeLabel.hidden = YES;
    self.tableView.header = header;
    
}


-(void)refreshClick:(id)sender{
    [self.result removeAllObjects];
    self.tableView.currentPage = 0;
    [self loadMoreData:nil];
}




-(void)loadMoreData:(id)obj{
    __block MyCouViewController *tempSelf = self;

    NSString *nPage = [NSString stringWithFormat:@"%ld",(long)(self.tableView.currentPage + 1)];
    if ([UserInfo shared].info == nil) {
        return;
    }
    [self.searchInfo setObject:nPage forKey:@"page"];

    
//    [self.searchInfo setObject:_textField.text forKey:@"key"];
    
    [[NetWork shared] startQuery:MyCouUrl
                            info:self.searchInfo
                   completeBlock:^(id Obj) {
                       
                       [tempSelf showNetworkError:[Obj intForKey:@"status"] == 0];
                       
                       if ([Obj intForKey:@"status"] == 1) {
                           NSArray *rs = [[Obj objectForKey:@"data"] objectForKey:@"list"];
                           NSDictionary *pageInfo = [[Obj objectForKey:@"data"] objectForKey:@"pageinfo"];
                           tempSelf.cdn = img1Url;// [Obj objectForKey:@"cdn"];
                           if ([rs count] > 0){
                               tempSelf.tableView.totalPage = [[pageInfo objectForKey:@"maxpage"] integerValue];
                               tempSelf.tableView.currentPage = [[pageInfo objectForKey:@"page"] integerValue];
                               [tempSelf.result addObjectsFromArray:rs];
                           }
                           
                       }
                       [tempSelf.tableView reloadData];
                       [tempSelf.tableView.header endRefreshing];
                       [tempSelf.tableView loadDataEnd];
                   }];
}


-(void)backClick:(id)sender{
    
    //    self.navigationItem.titleView = seg;
    //
    //    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(searchClick:)];
    //    barButtonItem.tintColor = [UIColor whiteColor];
    //    self.navigationItem.rightBarButtonItem = barButtonItem;
    //
    //    _searchBar.text = @"";
    
    _textField.text = @"";
    [_textField resignFirstResponder];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    _navBar.frame = CGRectMake(ScreenWidth, 0, ScreenWidth, 44);
    [UIView commitAnimations];
    [self reloadData];
}

-(void)searchClick:(id)sender{
    [self.navigationController.navigationBar bringSubviewToFront:_navBar];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    _navBar.frame = CGRectMake(0, 0, ScreenWidth, 44);
    [UIView commitAnimations];
    /*
     self.navigationItem.titleView = _searchBar;
     [_searchBar becomeFirstResponder];
     
     
     UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backClick:)];
     self.navigationItem.rightBarButtonItem = barButtonItem;
     */
}

-(void)reloadData{
    //重新加载数据
    [self.result removeAllObjects];
    self.tableView.currentPage = 0;
    [self loadMoreData:nil];
}

#pragma mark -
#pragma mark search bar


-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    [self reloadData];
    return YES;
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [_searchBar resignFirstResponder];
    [self reloadData];
}

#pragma mark -
#pragma mark 下拉列表方法

-(void)PullDownMenu:(MXPullDownMenu *)pullDownMenu didSelectRowAtColumn:(NSInteger)column row:(NSInteger)row{
    NSArray *keyArr = @[@"coutype",@"status",@"sort"];
    NSArray *valueArr = @[@[@"",@"1",@"2",@"3",@"4"],@[@"",@"9",@"10"],@[@"new",@"hot",@"costly"]];
    NSString *value =  [[valueArr objectAtIndex:column] objectAtIndex:row];
    [self.searchInfo setObject:value forKey:[keyArr objectAtIndex:column]];
    
    [self reloadData];
}




#pragma mark -
#pragma mark table view method

-(void)couCellButtonClick:(id)obj{
    if (self.navigationController){
        UINavigationController *nvc = [[UINavigationController alloc]initWithRootViewController:[[AddressViewController alloc]init]];
        [self hideTabBar];
        [self.navigationController.tabBarController presentViewController:nvc animated:YES completion:NULL];
    }else{
        UINavigationController *nvc = [[UINavigationController alloc]initWithRootViewController:[[AddressViewController alloc]init]];
        UIViewController *viewController = [self findViewController:[self.view superview]];
        [self hideTabBar];
        [viewController.navigationController.tabBarController presentViewController:nvc animated:YES completion:NULL];
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if([self checkScrollView:scrollView]){
        [self.tableView loadDataBegin];
    }
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CouDetailViewController *vc = [[CouDetailViewController alloc]init];
    vc.info = [self.result objectAtIndex:indexPath.row];
    if (self.ctype == CouViewTypeFromSetting) {
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        UIViewController *viewController = [self findViewController:[self.view superview]];
        [viewController.navigationController pushViewController:vc animated:YES];
    }


}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identify = @"Cell";
    CouCell *cell = (CouCell *)[tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[CouCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        cell.delegate = self;
        cell.backgroundColor =  [UIColor clearColor];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    
    cell.info = [self.result objectAtIndex:indexPath.row];
    cell.bAddress = [cell.info intForKey:@"is_address"] == 0;
    return cell;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  [self.result count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return CouCellHeight + CouCellGap;
}


//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 45;
//}

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
