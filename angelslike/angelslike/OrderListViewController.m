//
//  OrderListViewController.m
//  angelslike
//
//  Created by angelslike on 15/9/9.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import "OrderListViewController.h"

@interface OrderListViewController ()

@end

@implementation OrderListViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    

    
    [self initailSetting];
    [self loadMoreData:nil];
    
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)loadMoreData:(id)obj{
    __block OrderListViewController *tempSelf = self;
    NSString *nPage = [NSString stringWithFormat:@"%ld",self.tableView.currentPage + 1];
    
    
    [self.searchInfo setObject:nPage forKey:@"page"];
    [[NetWork shared] startQuery:MyOrderUrl
                            info:self.searchInfo
                   completeBlock:^(id Obj) {
                       NSArray *rs = [[Obj objectForKey:@"data"] objectForKey:@"list"];
                       NSDictionary *pageInfo = [[Obj objectForKey:@"data"] objectForKey:@"pageinfo"];
                       if ([rs count] > 0){
                           tempSelf.tableView.totalPage = [[pageInfo objectForKey:@"maxpage"] integerValue];
                           tempSelf.tableView.currentPage = [[pageInfo objectForKey:@"page"] integerValue];
                           [tempSelf.result addObjectsFromArray:rs];
                       }
                       [tempSelf.tableView reloadData];
                       [tempSelf.tableView loadDataEnd];
                       [tempSelf.tableView.header endRefreshing];
                   }];
}



-(void)initailSetting{
    
    self.navigationItem.title = @"我的订单";
    
    self.searchInfo = [NSMutableDictionary dictionaryWithObjectsAndKeys:[[UserInfo shared].info strForKey:@"loginkey"],@"loginkey",
                       @"new",@"sort",nil];
    
    //tableview
    self.result = [NSMutableArray array];
    self.tableView = [[LoadMoreTableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.currentPage = 0;
    self.tableView.totalPage = 0;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.contentInset = UIEdgeInsetsMake(35, 0, 0, 0);
    
    [self.tableView addTarget:self action:@selector(loadMoreData:)];
    [self.view addSubview:self.tableView];
    
    //pull down menu
    NSArray *nameArr;
    nameArr = @[@[@"全部状态", @"未付款", @"已付款",@"未发货" ,@"已发货", @"已完成"],
                @[@"按时间最新", @"按人气最高"]];
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
    //重新加载数据
    [self.result removeAllObjects];
    self.tableView.currentPage = 0;
    [self loadMoreData:nil];
}

#pragma mark -
#pragma mark 下拉菜单

-(void)PullDownMenu:(MXPullDownMenu *)pullDownMenu didSelectRowAtColumn:(NSInteger)column row:(NSInteger)row{
    NSArray *keyArr = @[@"status",@"sort"];
    NSArray *valueArr = @[@[@"",@"1",@"2",@"3",@"4",@"5"],
                          @[@"new",@"hot"]];
    NSString *value =  [[valueArr objectAtIndex:column] objectAtIndex:row];
    [self.searchInfo setObject:value forKey:[keyArr objectAtIndex:column]];
    
    [self refreshClick:nil];
}


-(void)cellClick:(UIButton *)b{
    if (b.tag == OrderCellType_Detail) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:[self GetSuperCell:b]];
        
        OrderDetailViewController *vc = [[OrderDetailViewController alloc]init];
        vc.orderid = [self.result[indexPath.row] strForKey:@"id"];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
//        PayReq* req             = [[PayReq alloc] init];
//        req.openID              = @"wx808df514e9cb4fc0";//[dict objectForKey:@"appid"];
//        req.partnerId           = @"1243239902";//[dict objectForKey:@"partnerid"];
//        req.prepayId            = @"wx201509181641334c3944c7010019625263";//[dict objectForKey:@"prepayid"];
//        req.nonceStr            = @"p2k0wcsux7neauikbxphcer4502zgrod";//[dict objectForKey:@"noncestr"];
//        req.timeStamp           = 1442565693;//stamp.intValue;
//        req.package             = @"prepay_id=wx201509181641334c3944c7010019625263";//[dict objectForKey:@"package"];
//        req.sign                = @"17C707409A59045A7095DDCE1C3BBBA4";//[dict objectForKey:@"sign"];
//        
//        [WXApi sendReq:req];

        
    }
}

#pragma mark table view method

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if( [self checkScrollView:scrollView])
    {
        [self.tableView loadDataBegin];
    }
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderViewCell *cell = (OrderViewCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[OrderViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    
    NSDictionary *info = [self.result objectAtIndex:indexPath.row];
    cell.info = info;
    return cell.frame.size.height;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identify = @"Cell";
    OrderViewCell *cell = (OrderViewCell *)[tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[OrderViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        cell.backgroundColor =  [UIColor clearColor];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell addTarget:self action:@selector(cellClick:)];
    }
    
    NSDictionary *info = [self.result objectAtIndex:indexPath.row];
    cell.info = info;
    return cell;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.result count] ;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
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
