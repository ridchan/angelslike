//
//  CommentViewController.m
//  angelslike
//
//  Created by angelslike on 15/8/25.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import "CommentViewController.h"

@implementation CommentViewController


-(void)dealloc{
    [anView removeFromSuperview];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (!viewisAppear) [self initialSetting]; viewisAppear = YES;
}

-(BOOL)automaticallyAdjustsScrollViewInsets{
    return NO;
}


-(void)initialSetting{
    CGFloat off = 0;
    
    
    self.tableView = [[LoadMoreTableView alloc]init];
    [self.view addSubview:self.tableView];
    if(self.navigationController){
        off = 66;
    }else{
        self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 89, 0);
        UIView *view =[self bottomView];
        view.frame = CGRectMake(0, self.view.frame.size.height - 89 , ScreenWidth, 40);
        [self.view addSubview:view];
    }
        
    
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


//    [self.view addSubview:view];
    
    
    
    
    self.heights = [NSMutableDictionary dictionary];
    [self refreshClick:nil];
    [self setBackButtonAction:@selector(backClick:)];
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"评论" style:UIBarButtonItemStylePlain target:self action:@selector(commentClick:)];
    self.navigationItem.rightBarButtonItem = right;
    
}

-(UIView *)bottomView{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 40)];
    view.backgroundColor = [UIColor whiteColor];
    
    UIButton *button = [self button:CGRectMake(15, 5, 250, 30)];
    [button addTarget:self action:@selector(commentClick:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    
    UIImageView *imageView =[[UIImageView alloc]initWithFrame:CGRectMake(280, 5, 30, 30)];
    imageView.image = [UIImage imageNamed:@"xiaolian"];
    [view addSubview:imageView];
    return view;
}

-(void)setReplay{
    anView = [[AnswerView alloc]init];
    anView.hidden = YES;
    
    __block CommentViewController *tempSlef = self;
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

-(void)backClick:(id)obj{
    if ([self.navigationController.viewControllers indexOfObject:self] > 0){
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self.navigationController dismissViewControllerAnimated:YES completion:NULL];
    }
}

-(void)commentClick:(id)obj{
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:self.info];
    [dic setObject:@"0" forKey:@"commentType"];
    [anView showWithObject:dic withTitle:@"请输入评论"];
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
    __block CommentViewController *tempSelf = self;
    NSString *nPage = [NSString stringWithFormat:@"%ld",(long)self.tableView.currentPage + 1];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:self.info];
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
        CommentCell *cell = (CommentCell *) [self GetSuperCell:view];
        NSMutableDictionary *info = [NSMutableDictionary dictionaryWithDictionary:cell.info];
        if (self.navigationController) {
            CommentAllViewController *vc = [[CommentAllViewController alloc] init];
            vc.info = info;
            UINavigationController *nvc = [[UINavigationController alloc]initWithRootViewController:vc];
            [self presentViewController:nvc animated:YES completion:NULL];
        }else{
            CommentAllViewController *vc = [[CommentAllViewController alloc] init];
            vc.info = info;
            UINavigationController *nvc = [[UINavigationController alloc]initWithRootViewController:vc];
            [[self findViewController:self.view] presentViewController:nvc animated:YES completion:NULL];
        }
    }else if (view.tag == CommentCellType_Praise){
        CommentCell *cell = (CommentCell *) [self GetSuperCell:view];
        NSMutableDictionary *info = [NSMutableDictionary dictionaryWithDictionary:cell.info];
        __block CommentViewController *tempSelf = self;
        [view.layer addAnimation:[self animation] forKey:@"move"];
        [[NetWork shared] query:PraiseUrl info:@{@"type":@"theme",@"id":[info strForKey:@"id"]} block:^(id Obj) {
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

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if([self checkScrollView:scrollView]){
        [self.tableView loadDataBegin];
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identify = @"Cell";
    CommentCell *cell = (CommentCell *)[tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[CommentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell addTarget:self action:@selector(cellAtionClick:)];
    }
    
    cell.info = [self.result objectAtIndex:indexPath.row];
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([self.heights objectForKey:indexPath]) {
        return [[self.heights objectForKey:indexPath] floatValue];
    }else{
        static NSString *identify = @"Cell";
        CommentCell *cell = (CommentCell *)[tableView dequeueReusableCellWithIdentifier:identify];
        if (cell == nil) {
            cell = [[CommentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
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


@end
