//
//  ProductRecordViewController.m
//  angelslike
//
//  Created by angelslike on 15/9/17.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import "ProductRecordViewController.h"

@interface ProductRecordViewController ()

@end

@implementation ProductRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initialSetting];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)backClick:(id)obj{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)initialSetting{
    CGFloat off = 0;
    
    self.tableView = [[LoadMoreTableView alloc]init];
    [self.view addSubview:self.tableView];
    
    //table view
    self.result = [NSMutableArray array];
    self.tableView.frame =  CGRectMake(0, off, ScreenWidth, self.view.frame.size.height - off);
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.currentPage = 0;
    self.tableView.totalPage = 0;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
    
    [self.tableView addTarget:self action:@selector(loadMoreData:)];
    
    [self refreshClick:nil];
    [self setBackButtonAction:@selector(backClick:)];
    
    
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //
    }
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}


-(void)refreshClick:(id)sender{
    [self.result removeAllObjects];
    self.tableView.currentPage = 0;
    [self loadMoreData:nil];
}

-(void)loadMoreData:(id)sender{
    __block ProductRecordViewController *tempSelf = self;
    
    NSString *nPage = [NSString stringWithFormat:@"%ld",(long)self.tableView.currentPage + 1];
    
    
    NSDictionary *dic = @{@"id":self.strid,@"page":nPage};
    [[NetWork shared] startQuery:self.strurl
                            info:dic
                   completeBlock:^(id Obj) {
                       
                       if ([Obj intForKey:@"status"] == 1) {
                           NSArray *rs = [[Obj objectForKey:@"data"] objForKey:@"list"];
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


#pragma mark -
#pragma mark tableview delegate



-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if([self checkScrollView:scrollView]){
        [self.tableView loadDataBegin];
    }
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identify = @"Cell";
    ProductRecordCell *cell = (ProductRecordCell *)[tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[ProductRecordCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    cell.info = self.result[indexPath.row];
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 62;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  [self.result count];
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
