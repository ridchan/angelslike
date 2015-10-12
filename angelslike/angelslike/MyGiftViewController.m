//
//  MyGiftViewController.m
//  angelslike
//
//  Created by angelslike on 15/10/10.
//  Copyright © 2015年 angelslike. All rights reserved.
//

#import "MyGiftViewController.h"
#import "ProductDetailViewController.h"
#import "GiftSendViewController.h"

@interface MyGiftViewController ()

@end

@implementation MyGiftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialSetting];
    [self setBackButtonAction:@selector(backClick:)];
    [self refreshClick:nil];
    // Do any additional setup after loading the view.
}

-(void)backClick:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initialSetting{

    //顶部配置
    self.navigationItem.title = @"送出的礼物";
    seg = [[UISegmentedControl alloc]initWithItems:@[@"送出的",@"收到的"]];
    seg.frame = CGRectMake(0, 6 , 200, 32);
    seg.tintColor = [UIColor whiteColor];
    seg.selectedSegmentIndex = 0;
    self.navigationItem.titleView = seg;
    [seg addTarget:self action:@selector(viewChange:) forControlEvents:UIControlEventValueChanged];
    
    
    //table view
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
    

    
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshClick:)];
    header.automaticallyChangeAlpha = YES;
    header.lastUpdatedTimeLabel.hidden = YES;
    self.tableView.header = header;
    

    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if([self checkScrollView:scrollView]){
        [self.tableView loadDataBegin];
    }
}


-(void)refreshClick:(id)obj{
    [self.result removeAllObjects];
    self.tableView.currentPage = 0;
    self.tableView.totalPage = 0;
    [self loadMoreData:nil];
}

-(void)loadMoreData:(id)obj{
    __block MyGiftViewController *tempSelf = self;
    NSString *nPage = [NSString stringWithFormat:@"%ld",(long)(self.tableView.currentPage + 1)];
    NSString *type = seg.selectedSegmentIndex == 0?@"list_gift_send":@"list_gift_get";
    
    [[NetWork shared] query:MPUrl
                       info:@{@"page":nPage,@"type":type}
                      block:^(id Obj) {
                          
                          [tempSelf showNetworkError:[Obj intForKey:@"status"] == 0];
                          
                          if ([Obj intForKey:@"status"] == 1) {
                              NSArray *rs = [[Obj objForKey:@"data"] objForKey:@"list"];
                              NSDictionary *pageInfo = [[Obj objForKey:@"data"] objForKey:@"pageinfo"];
                              
                              if ([rs count] > 0){
                                  tempSelf.tableView.totalPage = [[pageInfo objForKey:@"maxpage"] integerValue];
                                  tempSelf.tableView.currentPage = [[pageInfo objForKey:@"page"] integerValue];
                                  [tempSelf.result addObjectsFromArray:rs];
                              }
                              
                          }
                          [tempSelf.tableView reloadData];
                          [tempSelf.tableView.header endRefreshing];
                          [tempSelf.tableView loadDataEnd];
                      } lock:NO];
}

-(void)viewChange:(id)obj{
    __block MyGiftViewController *tempSelf = self;
    NSString *nPage = @"1";
    NSString *type = seg.selectedSegmentIndex == 0?@"list_gift_send":@"list_gift_get";
    [self.result removeAllObjects];
    [[NetWork shared] query:MPUrl
                       info:@{@"page":nPage,@"type":type}
                       block:^(id Obj) {
                       
                       [tempSelf showNetworkError:[Obj intForKey:@"status"] == 0];
                       
                       if ([Obj intForKey:@"status"] == 1) {
                           NSArray *rs = [[Obj objForKey:@"data"] objForKey:@"list"];
                           NSDictionary *pageInfo = [[Obj objForKey:@"data"] objForKey:@"pageinfo"];
                           
                           if ([rs count] > 0){
                               tempSelf.tableView.totalPage = [[pageInfo objectForKey:@"maxpage"] integerValue];
                               tempSelf.tableView.currentPage = [[pageInfo objectForKey:@"page"] integerValue];
                               [tempSelf.result addObjectsFromArray:rs];
                           }
                           
                       }
                       [tempSelf.tableView reloadData];
                       [tempSelf.tableView.header endRefreshing];
                       [tempSelf.tableView loadDataEnd];
                   } lock:YES];
}

-(void)cellTap:(MyGiftCell *)cell{
    if (cell.isLeft) {
        if ([[cell.info strForKey:@"pid"] length] > 0){
            ProductDetailViewController *vc = [[ProductDetailViewController alloc]init];
            vc.info = @{@"id":[cell.info strForKey:@"pid"]};
            [self.navigationController pushViewController:vc animated:YES];
        }
    }else if (seg.selectedSegmentIndex == 0){
        GiftSendViewController *vc = [[GiftSendViewController alloc]init];
        vc.info = cell.info;
        [self.navigationController pushViewController:vc animated:YES];
    }
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identify = @"Cell";
    MyGiftCell *cell = (MyGiftCell *)[tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[MyGiftCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        cell.backgroundColor =  [UIColor whiteColor];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell addTarget:self action:@selector(cellTap:)];
    }
    
    cell.type = seg.selectedSegmentIndex;
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
    return 150;
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
