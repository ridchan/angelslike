//
//  CouRecordsViewController.m
//  angelslike
//
//  Created by angelslike on 15/9/7.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import "CouRecordsViewController.h"

@interface CouRecordsViewController ()

@end

@implementation CouRecordsViewController

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (!bload) [self initialSetting]; bload = YES;
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}




-(void)initialSetting{
    
    
    self.heights = [NSMutableDictionary dictionary];
    
    //table view
    self.result = [NSMutableArray array];
    self.tableView = [[LoadMoreTableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, self.view.frame.size.height - 44)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.currentPage = 0;
    self.tableView.totalPage = 0;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
    //    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 40, 0);
    [self.tableView addTarget:self action:@selector(loadMoreData:)];
    [self.view addSubview:self.tableView];
    
    
    [self setReplay];
//    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 40)];
//    view.backgroundColor = [UIColor whiteColor];
//    
//    UITextField *textField = [self textField:CGRectMake(15, 5, 250, 30)];
//    [view addSubview:textField];
//    
//    UIImageView *imageView =[[UIImageView alloc]initWithFrame:CGRectMake(280, 5, 30, 30)];
//    imageView.image = [UIImage imageNamed:@"xiaolian"];
//    [view addSubview:imageView];
//    
//    self.tableView.tableFooterView = view;
//    
//    [self.view addSubview:view];
    
    
    //    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshClick:)];
    //    header.automaticallyChangeAlpha = YES;
    //    header.lastUpdatedTimeLabel.hidden = YES;
    //    self.tableView.header = header;
    //
    [self refreshClick:nil];
}


-(UITextField *)textField:(CGRect)frame{
    UITextField *txt = [[UITextField alloc]initWithFrame:frame];
    txt.font = FontWS(14);
    txt.backgroundColor = [UIColor getHexColor:@"F8F8F8"];
    txt.borderStyle = UITextBorderStyleNone;
    txt.layer.borderColor = [UIColor getHexColor:@"bbbbbb"].CGColor;
    txt.layer.borderWidth = 1.0;
    txt.layer.cornerRadius = 4;
    txt.layer.masksToBounds = YES;
    return txt;
}

-(UIButton *)button:(CGRect)frame{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    button.backgroundColor = [UIColor getHexColor:@"F8F8F8"];
    
    button.layer.borderColor = [UIColor getHexColor:@"bbbbbb"].CGColor;
    button.layer.borderWidth = 1.0;
    button.layer.cornerRadius = 4;
    button.layer.masksToBounds = YES;
    return button;
}

-(void)refreshClick:(id)sender{
    [self.result removeAllObjects];
    self.tableView.currentPage = 0;
    [self loadMoreData:nil];
}

-(void)loadMoreData:(id)sender{
    __block CouRecordsViewController *tempSelf = self;
    NSString *nPage = [NSString stringWithFormat:@"%ld",(long)self.tableView.currentPage + 1];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:self.info];
    [dic setObject:nPage forKey:@"page"];
    [[NetWork shared] startQuery:CouRecordUrl
                            info:dic
                   completeBlock:^(id Obj) {
                       
                       [tempSelf showNetworkError:[Obj intForKey:@"status"] == 0];
                       
                       if ([Obj intForKey:@"status"] == 1) {
                           NSArray *rs = [[Obj objectForKey:@"data"] objForKey:@"list"];
                           NSDictionary *pageInfo = [[Obj objectForKey:@"data"] objectForKey:@"pageinfo"];
                           //                           tempSelf.cdn = ImageLink;// [Obj objectForKey:@"cdn"];
                           
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

-(void)setReplay{
    anView = [[AnswerView alloc]init];
    anView.hidden = YES;
    
    __block CouRecordsViewController *tempSlef = self;
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

-(void)cellClick:(UIView *)view{
    CouRecrodCell *cell = (CouRecrodCell *) [self GetSuperCell:view];
    NSMutableDictionary *info = [NSMutableDictionary dictionaryWithDictionary:cell.info];
    
    if (view.tag == CouCellType_Comment) {
        [info setObject:@"5" forKey:@"commentType"];
        [anView showWithObject:info withTitle:@"请输入评论"];
    }else if (view.tag == CouCellType_More){
        CommentAllViewController *vc = [[CommentAllViewController alloc]init];
        vc.info = info;
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
        [[self findViewController:self.view] presentViewController:nav animated:YES completion:NULL];
    }else{
    
        CouRecrodCell *cell = (CouRecrodCell *) [self GetSuperCell:view];
        NSMutableDictionary *info = [NSMutableDictionary dictionaryWithDictionary:cell.info];
        __block CouRecordsViewController *tempSelf = self;
        [view.layer addAnimation:[self animation] forKey:@"move"];
        [[NetWork shared] query:PraiseUrl info:@{@"type":@"cou",@"id":[info strForKey:@"id"]} block:^(id Obj) {
            if ([Obj intForKey:@"status"] == 0) {
                [tempSelf showMessage:[Obj strForKey:@"info"]];
            }
            
        } lock:NO];
    }
}

-(CABasicAnimation *)animation{
    CABasicAnimation *an = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    an.duration = 0.35;
    //    an.fromValue = [];
    an.toValue = [NSNumber numberWithInt:-10];
    an.removedOnCompletion = YES;
    an.autoreverses = YES;
    an.fillMode = kCAFillModeForwards;
    return an;
}

#pragma mark -
#pragma mark tableview delegate



-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.y <= 0){
        self.view.userInteractionEnabled = NO;
        [self.view resignFirstResponder];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"MoveMoveMove" object:nil];
    }
    if([self checkScrollView:scrollView]){
        [self.tableView loadDataBegin];
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identify = @"Cell";
    CouRecrodCell *cell = (CouRecrodCell *)[tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[CouRecrodCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell addTarget:self action:@selector(cellClick:)];
    }
    
    cell.info = [self.result objectAtIndex:indexPath.row];
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.heights objectForKey:indexPath]) {
        return [[self.heights objectForKey:indexPath] floatValue];
    }else{
        static NSString *identify = @"Cell";
        CouRecrodCell *cell = (CouRecrodCell *)[tableView dequeueReusableCellWithIdentifier:identify];
        if (cell == nil) {
            cell = [[CouRecrodCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
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

@end
