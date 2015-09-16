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
    
    
    scrolerHeight = ScreenWidth * 9 / 16;
    cellHeight = (ScreenWidth - MainCellMargin * 2) * 49 / 108 + MainCellGap; // 108:49
    
    [self initailSetting];
    
    [self loadMoreData:nil];
    
    // Do any additional setup after loading the view.
}

-(void)refreshClick:(id)sender{
    [scroller start:SliderLink];
    [self loadMoreData:nil];
}

-(void)loadMoreData:(id)obj{
    __block MainViewController *tempSelf = self;
    NSString *nPage = [NSString stringWithFormat:@"%ld",self.tableView.currentPage + 1];
    [[NetWork shared] startQuery:ListLink
                            info:@{@"page":nPage,@"sort":@"new"}
                   completeBlock:^(id Obj) {
                       [tempSelf  showNetworkError:[Obj intForKey:@"status"] == 0];
                       if ([Obj intForKey:@"status"] == 1) {
                           NSArray *rs = [[Obj objectForKey:@"data"] objectForKey:@"list"];
                           NSDictionary *pageInfo = [[Obj objectForKey:@"data"] objectForKey:@"pageinfo"];
                           tempSelf.cdn = img1Url;// [Obj objectForKey:@"cdn"];
                           if ([rs count] > 0){
                               tempSelf.tableView.totalPage = [[pageInfo objectForKey:@"maxpage"] integerValue];
                               tempSelf.tableView.currentPage = [[pageInfo objectForKey:@"page"] integerValue];
                               [tempSelf.result addObjectsFromArray:rs];
                               [tempSelf.tableView reloadData];
                           }
                       }
                       [tempSelf.tableView.header endRefreshing];
                       [tempSelf.tableView loadDataEnd];
    }];
}

-(void)initailSetting{
    self.navigationItem.title = @"天使礼客";
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
    
    scroller =  [[ImageScroller alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, scrolerHeight)];
    [scroller start:SliderLink];
    
    banner = [[Banner alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 60)];
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshClick:)];
//    [header setBackgroundColor:[UIColor getHexColor:@"ff6969"]];
    header.automaticallyChangeAlpha = YES;
    header.lastUpdatedTimeLabel.hidden = YES;
    self.tableView.header = header;
    
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

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if( scrollView.contentOffset.y > ((scrollView.contentSize.height - scrollView.frame.size.height - 20)))
    {
        [self.tableView loadDataBegin];
    }
}

//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
//
//{
//    
//    // 下拉到最底部时显示更多数据
//    
//    if( scrollView.contentOffset.y > ((scrollView.contentSize.height - scrollView.frame.size.height)))
//    {
//        [self.tableView loadDataBegin];
//    }
//    
//    
//}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row > 1) {
        NSDictionary *info = [self.result objectAtIndex:indexPath.row - 2];
        ThemeDetailViewController *vc = [[ThemeDetailViewController alloc]init];
//        vc.hidesBottomBarWhenPushed = YES;
        vc.strid = [info strForKey:@"id"];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Slider"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Slider"];
            [cell addSubview:scroller];
            cell.backgroundColor =  [UIColor clearColor];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        }

        return cell;
    }else if (indexPath.row == 1){
        UITableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:@"Banner"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Banner"];
            [cell addSubview:banner];
            cell.backgroundColor =  [UIColor clearColor];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        }
        
        return cell;
        
    }else{
        static NSString *identify = @"Cell";
        MainCell *cell = (MainCell *)(MainCell *)[tableView dequeueReusableCellWithIdentifier:identify];
        if (cell == nil) {
            cell = [[MainCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
            cell.backgroundColor =  [UIColor clearColor];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        }
        
        NSDictionary *info = [self.result objectAtIndex:indexPath.row - 2];
        NSString *link = [self.cdn stringByAppendingPathComponent:[info objectForKey:@"img"]];
        [cell setImageView:link];
        [cell setName:[info objectForKey:@"title"]];
        return cell;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  [self.result count] == 0?0:[self.result count] + 2;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return scrolerHeight ;// banner  16:9
    }else if(indexPath.row == 1) {
        return 70;
    }else{
        return cellHeight ;
    }
}



@end
