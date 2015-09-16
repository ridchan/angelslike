//
//  CommentAllViewController.m
//  angelslike
//
//  Created by angelslike on 15/9/14.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import "CommentAllViewController.h"

@interface CommentAllViewController ()

@end

@implementation CommentAllViewController

-(void)dealloc{
    [anView removeFromSuperview];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initialSetting];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)backClick:(id)obj{
    [self.navigationController dismissViewControllerAnimated:YES completion:NULL];
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
    
    //
    
    [self setReplay];
    
    //
    
    self.heights = [NSMutableDictionary dictionary];
    [self refreshClick:nil];
    [self setBackButtonAction:@selector(backClick:)];
    
    [self setHeaderView];
    
}

-(void)setHeaderView{
    
    CommentCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[CommentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    NSMutableDictionary *newInfo = [NSMutableDictionary dictionaryWithDictionary:self.info];
    [newInfo removeObjectForKey:@"comment_list"];
    cell.info = newInfo;
    [cell addTarget:self action:@selector(cellAtionClick:)];
    
    self.headerCell = cell;
    
}




-(void)setReplay{
    anView = [[AnswerView alloc]init];
    anView.hidden = YES;
    
    __block CommentAllViewController *tempSlef = self;
    anView.block = ^(id obj,AnswerViewType type){
        if (type == AnswerViewType_Comfrim) {
            NSDictionary *info = [obj objectForKey:@"object"];
            NSString *content = [obj objectForKey:@"content"];
            [[NetWork shared]query:CommentAddUrl info:@{@"type":[info strForKey:@"commentType"],@"id":[info strForKey:@"id"],@"content":content,@"loginkey":[[UserInfo shared].info strForKey:@"loginkey"]} block:^(id Obj) {
                [tempSlef refreshClick:nil];
                
            } lock:YES];
        }
    };
}


-(void)refreshClick:(id)sender{
    [self.result removeAllObjects];
    self.tableView.currentPage = 0;
    [self loadMoreData:nil];
}

-(void)loadMoreData:(id)sender{
    __block CommentAllViewController *tempSelf = self;
    NSString *nPage = [NSString stringWithFormat:@"%ld",self.tableView.currentPage + 1];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:self.info];
    [dic setObject:@"3" forKey:@"type"];
    [dic setObject:nPage forKey:@"page"];
    [[NetWork shared] startQuery:CommentsUrl
                            info:dic
                   completeBlock:^(id Obj) {
                       
                       [tempSelf showNetworkError:[Obj intForKey:@"status"] == 0];
                       
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
                       //                       [tempSelf.tableView.header endRefreshing];
                       [tempSelf.tableView loadDataEnd];
                   }];
}


#pragma mark -
#pragma mark tableview delegate

-(void)cellAtionClick:(UIView *)view{
    
    if (view.tag == CommentCellType_Comment) {
        CommentCell *cell = (CommentCell *) [self GetSuperCell:view];
        NSMutableDictionary *info = [NSMutableDictionary dictionaryWithDictionary:cell.info];
        [info setObject:@"3" forKey:@"commentType"];
        [anView showWithObject:info withTitle:@"请输入评论"];
    }else if (view.tag == CommentCellType_ShowMore){
        
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if([self checkScrollView:scrollView]){
        [self.tableView loadDataBegin];
    }
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return self.headerCell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return self.headerCell.frame.size.height;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identify = @"Cell";
    SubCommentCell *cell = (SubCommentCell *)[tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[SubCommentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    
    cell.info = [self.result objectAtIndex:indexPath.row];
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([self.heights objectForKey:indexPath]) {
        return [[self.heights objectForKey:indexPath] floatValue];
    }else{
        static NSString *identify = @"Cell";
        SubCommentCell *cell = (SubCommentCell *)[tableView dequeueReusableCellWithIdentifier:identify];
        if (cell == nil) {
            cell = [[SubCommentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        }
        
        cell.info = [self.result objectAtIndex:indexPath.row];
        [self.heights setObject:[NSNumber numberWithFloat:cell.frame.size.height + 1] forKey:indexPath];
        return cell.frame.size.height + 1 ;
    }
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  [self.result count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
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
