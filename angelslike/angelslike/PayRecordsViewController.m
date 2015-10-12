//
//  PayRecordsViewController.m
//  angelslike
//
//  Created by angelslike on 15/9/15.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import "PayRecordsViewController.h"

@interface PayRecordsViewController ()

@end

@implementation PayRecordsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"支付记录";
    [self initialSetting];
    [self loadMoreData:nil];
    // Do any additional setup after loading the view.
}

-(void)initialSetting{
    self.result = [NSMutableArray array];
    self.tableView = [[LoadMoreTableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.currentPage = 0;
    self.tableView.totalPage = 0;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
//    self.tableView.contentInset = UIEdgeInsetsMake(44, 0, 0, 0);
    [self.tableView addTarget:self action:@selector(loadMoreData:)];
    [self.view addSubview:self.tableView];
}

-(void)refreshClick:(id)sender{
    [self loadMoreData:nil];
}

-(void)loadMoreData:(id)obj{
    __block PayRecordsViewController *tempSelf = self;
  
    NSString *nPage = [NSString stringWithFormat:@"%d",(int)self.tableView.currentPage + 1];

    [[NetWork shared] startQuery:MyPayRecordUrl
                            info:@{@"loginkey":[[UserInfo shared].info strForKey:@"loginkey"],@"page":nPage}
                   completeBlock:^(id Obj) {
                       
                       [tempSelf showNetworkError:[Obj intForKey:@"status"] == 0];
                       
                       if ([Obj intForKey:@"status"] == 1) {
                           NSArray *rs = [[Obj objectForKey:@"data"] objectForKey:@"list"];
                           NSDictionary *pageInfo = [[Obj objectForKey:@"data"] objectForKey:@"pageinfo"];
                           if ([rs count] > 0){
                               tempSelf.tableView.totalPage = [[pageInfo objectForKey:@"maxpage"] integerValue];
                               tempSelf.tableView.currentPage = [[pageInfo objectForKey:@"page"] integerValue];
                               [tempSelf.result addObjectsFromArray:rs];
                           }
                           
                       }
                       [tempSelf.tableView reloadData];
                       [tempSelf.tableView loadDataEnd];
                   }];
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

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if([self checkScrollView:scrollView]){
        [self.tableView loadDataBegin];
    }
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identify = @"Cell";
    PayRecordCell *cell = (PayRecordCell *)[tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[PayRecordCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
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
    return 150;
}

@end
