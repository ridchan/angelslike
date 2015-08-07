//
//  ThemeViewController.m
//  angelslike
//
//  Created by angelslike on 15/8/7.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import "ThemeViewController.h"

@implementation ThemeViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    cellHeight = (ScreenWidth - MainCellMargin * 2) * 49 / 108 + MainCellGap; // 108:49
    
    [self initailSetting];
    [self loadMoreData:nil];

}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)loadMoreData:(id)obj{
    __block ThemeViewController *tempSelf = self;
    NSString *nPage = [NSString stringWithFormat:@"%ld",self.tableView.currentPage + 1];
    

    [self.searchInfo setObject:nPage forKey:@"page"];
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
                           [tempSelf.tableView reloadData];
                       }
                       [tempSelf.tableView loadDataEnd];
                   }];
}



-(void)initailSetting{
    
    self.searchInfo = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"list_theme",@"type",
                       @"new",@"sort",nil];

    //tableview
    self.result = [NSMutableArray array];
    self.tableView = [[LoadMoreTableView alloc]initWithFrame:CGRectMake(0, 64 + 35, ScreenWidth, ScreenHeight - 64 - 35 - 49)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.currentPage = 0;
    self.tableView.totalPage = 0;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
//    self.tableView.contentInset = UIEdgeInsetsMake(108, 0, 0, 0);
    [self.tableView addTarget:self action:@selector(loadMoreData:)];
    [self.view addSubview:self.tableView];
    
    //pull down menu
    NSArray *nameArr;
    nameArr = @[@[@"全部对象", @"送长辈", @"送恋人", @"送同事", @"送朋友", @"送老师", @"送儿童", @"送亲人", @"送嘉宾"],
                @[@"全部场景", @"亲情礼" ,@"爱情礼", @"人情礼", @"生日礼", @"婚庆礼", @"节日礼"],
                @[@"按时间最新", @"按人气最高"]];
    downMenu = [[MXPullDownMenu alloc] initWithArray:nameArr selectedColor:[UIColor getHexColor:@"FE6869"]];
    downMenu.delegate = self;
    downMenu.frame = CGRectMake(0, 64, ScreenWidth, 35);
    [self.view addSubview:downMenu];

}

-(void)reloadData{
    //重新加载数据
    [self.result removeAllObjects];
    self.tableView.currentPage = 0;
    [self loadMoreData:nil];
}

#pragma mark -
#pragma mark 下拉菜单

-(void)PullDownMenu:(MXPullDownMenu *)pullDownMenu didSelectRowAtColumn:(NSInteger)column row:(NSInteger)row{
    NSArray *keyArr = @[@"object",@"scenes",@"sort"];
    NSArray *valueArr = @[@[@"",@"39",@"35",@"36",@"37",@"60",@"38",@"61",@"62"],
                          @[@"",@"41",@"42",@"44",@"45",@"63",@"46"],
                          @[@"new",@"hot"]];
    NSString *value =  [[valueArr objectAtIndex:column] objectAtIndex:row];
    [self.searchInfo setObject:value forKey:[keyArr objectAtIndex:column]];
    
    [self reloadData];
}


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

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *identify = @"Cell";
    MainCell *cell = (MainCell *)(MainCell *)[tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[MainCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        cell.backgroundColor =  [UIColor clearColor];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    
    NSDictionary *info = [self.result objectAtIndex:indexPath.row];
    NSString *link = [self.cdn stringByAppendingPathComponent:[info objectForKey:@"img"]];
    [cell setImageView:link];
    [cell setName:[info objectForKey:@"title"]];
    return cell;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.result count] ;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return cellHeight ;
    
}


@end
