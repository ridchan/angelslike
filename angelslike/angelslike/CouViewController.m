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
    
    self.searchInfo = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"list_cou",@"type",
                                                                        @"new",@"sort",nil];
    //顶部配置
    seg = [[UISegmentedControl alloc]initWithItems:@[@"谁在凑分子",@"我的凑分子"]];
    seg.tintColor = [UIColor whiteColor];
    seg.selectedSegmentIndex = 0;
    self.navigationItem.titleView = seg;
    
    //搜索按钮
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(searchClick:)];
    barButtonItem.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = barButtonItem;
    
    //搜索框
    _searchBar  = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, 10, 28)];
    _searchBar.barStyle = UIBarStyleDefault;
    _searchBar.backgroundColor = [UIColor clearColor];
    _searchBar.tintColor = [UIColor clearColor];
    _searchBar.delegate  = self;


//    searchDisplayController = [[UISearchDisplayController alloc]initWithSearchBar:_searchBar contentsController:self];
    
    
    //    [self.navigationItem.backBarButtonItem setTitle:@""];
    [self.navigationItem setHidesBackButton:YES];
    

    //table view
    self.result = [NSMutableArray array];
    self.tableView = [[LoadMoreTableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.currentPage = 0;
    self.tableView.totalPage = 0;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.contentInset = UIEdgeInsetsMake(44, 0, 0, 0);
    [self.tableView addTarget:self action:@selector(loadMoreData:)];
    [self.view addSubview:self.tableView];
    
    
    //pull down menu
    NSArray *nameArr;
    nameArr = @[ @[ @"全部类型", @"人情凑", @"颜值凑", @"爱心凑", @"随便凑"], @[@"全部状态", @"进行中" ,@"已完成"], @[@"按时间最新", @"按人气最高", @"按总价最贵"]];
    downMenu = [[MXPullDownMenu alloc] initWithArray:nameArr selectedColor:[UIColor getHexColor:@"FE6869"]];
    downMenu.delegate = self;
    downMenu.frame = CGRectMake(0, 64, ScreenWidth, 35);
    [self.view addSubview:downMenu];
 
}


-(void)loadMoreData:(id)obj{
    __block CouViewController *tempSelf = self;
    NSString *nPage = [NSString stringWithFormat:@"%ld",self.tableView.currentPage + 1];
    [self.searchInfo setObject:nPage forKey:@"page"];
    [self.searchInfo setObject:_searchBar.text forKey:@"key"];
    
    [[NetWork shared] startQuery:ListLink
                            info:self.searchInfo
                   completeBlock:^(id Obj) {
                       NSArray *rs = [[Obj objectForKey:@"data"] objectForKey:@"list"];
                       NSDictionary *pageInfo = [[Obj objectForKey:@"data"] objectForKey:@"pageinfo"];
                       tempSelf.cdn = [Obj objectForKey:@"cdn"];
                       if ([rs count] > 0){
                           tempSelf.tableView.totalPage = [[pageInfo objectForKey:@"maxpage"] integerValue];
                           tempSelf.tableView.currentPage = [[pageInfo objectForKey:@"page"] integerValue];
                           [tempSelf.result addObjectsFromArray:rs];
                       }
                       [tempSelf.tableView reloadData];
                       [tempSelf.tableView loadDataEnd];
                   }];
}


-(void)backClick:(id)sender{
    
    self.navigationItem.titleView = seg;

    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(searchClick:)];
    barButtonItem.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = barButtonItem;
    
    _searchBar.text = @"";
    [self reloadData];
}

-(void)searchClick:(id)sender{

    self.navigationItem.titleView = _searchBar;
    [_searchBar becomeFirstResponder];

    
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backClick:)];
    self.navigationItem.rightBarButtonItem = barButtonItem;
    
}

-(void)reloadData{
    //重新加载数据
    [self.result removeAllObjects];
    self.tableView.currentPage = 0;
    [self loadMoreData:nil];
}

#pragma mark -
#pragma mark search bar

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

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if( scrollView.contentOffset.y > ((scrollView.contentSize.height - scrollView.frame.size.height - 20))){
        [self.tableView loadDataBegin];
    }
}



//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    NSLog(@"return %@",downMenu);
//    return downMenu;
//}


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