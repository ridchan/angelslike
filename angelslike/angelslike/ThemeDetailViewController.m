//
//  ThemeDetailViewController.m
//  angelslike
//
//  Created by angelslike on 15/8/27.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import "ThemeDetailViewController.h"

@implementation ThemeDetailViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    
    self.indexs = [NSMutableDictionary dictionary];
    [self initialSetting];
    [self addBottomView];
    [self loadData];
    
    
}

-(BOOL)prefersStatusBarHidden{
    return NO;
}

-(void)addBottomView{
    bv = [[BottomView alloc]initWithFrame:CGRectMake(0, ScreenHeight - 44, ScreenWidth, 44)];
    [self.view addSubview:bv];
}

-(void)setBottomView{
    [bv setCount:[self.result strForKey:@"praise"] count2:[self.result strForKey:@"review"] count3:[self.result strForKey:@"share"]];
    [bv addTarget:self action:@selector(bottomButtonClick:)];
}

-(void)bottomButtonClick:(UIButton *)sender{
    if (sender.tag == 2) {
        
        CommentViewController *vc =[[CommentViewController alloc]init];
        vc.info = @{@"id":self.strid,@"type":@"0"};
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
        [self presentViewController:nav animated:YES completion:NULL];
        
    }else if(sender.tag == 3){
        
        [self shareContent:[self.result strForKey:@"content"]
                     title:[self.result strForKey:@"title"]
                 imagePath:[self.result strForKey:@"img"]
                       url:[ThemeShareUrl stringByAppendingPathComponent:[self.result objectForKey:@"id"]]];
        
    }else if (sender.tag == 1){
        __block ThemeDetailViewController *tempSelf = self;
        [[NetWork shared] query:PraiseUrl info:@{@"type":@"theme",@"id":[self.result strForKey:@"id"]} block:^(id Obj) {
            if ([Obj intForKey:@"status"] == 0) {
                [tempSelf showMessage:[Obj strForKey:@"info"]];
            }
            
        } lock:NO];
    }
}

-(void)initialSetting{
    self.navigationItem.title = @"攻略详情";
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.tableView];
}

-(void)refreshClick:(id)sender{
    [self loadData];
}

-(void)loadData{
    __block ThemeDetailViewController *tempSelf = self;
    [[NetWork shared] startQuery:ThemeUrl
                            info:@{@"id":self.strid}
                   completeBlock:^(id Obj) {
                       
                       [tempSelf showNetworkError:[Obj intForKey:@"status"] == 0];
                       
                       if ([Obj intForKey:@"status"] == 1) {
                           tempSelf.result = [Obj objectForKey:@"data"] ;
                           [tempSelf setBottomView];
  
                       }
                       [tempSelf.tableView reloadData];
                   }];
}

#pragma mark -
#pragma mark table view

-(void)checkButtonClick:(id)sender{
    ProductDetailViewController *vc = [[ProductDetailViewController alloc]init];
    vc.info = sender;
    [self.navigationController pushViewController:vc animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        static NSString *topIdentify = @"TopCell";
        TopCell *cell = (TopCell *)[tableView dequeueReusableCellWithIdentifier:topIdentify];
        if (cell == nil) {
            cell = [[TopCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:topIdentify];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            
        }
        
        [cell setContent:[self.result strForKey:@"content"] image:[self.result strForKey:@"img"]];
        if (![self.indexs objectForKey:indexPath]) {
            [self.indexs setObject:[NSString stringWithFormat:@"%0.2f",cell.frame.size.height] forKey:indexPath];
        }
    }else{
        static NSString *itemIdentify = @"ItemCell";
        ItemCell *cell = (ItemCell *)[tableView dequeueReusableCellWithIdentifier:itemIdentify];
        if (cell == nil) {
            cell = [[ItemCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:itemIdentify];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        }
        
        cell.info = [[self.result objectForKey:@"details"] objectAtIndex:indexPath.row - 1];
        if (![self.indexs objectForKey:indexPath]) {
            [self.indexs setObject:[NSString stringWithFormat:@"%0.2f",cell.frame.size.height] forKey:indexPath];
        }
    }
    NSLog(@"height %@",[self.indexs objectForKey:indexPath]);
    return [[self.indexs objectForKey:indexPath] floatValue];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.row == 0) {
        static NSString *topIdentify = @"TopCell";
        TopCell *cell = (TopCell *)[tableView dequeueReusableCellWithIdentifier:topIdentify];
        if (cell == nil) {
            cell = [[TopCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:topIdentify];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            
        }
        
        [cell setContent:[self.result strForKey:@"content"] image:[self.result strForKey:@"img"]];
        if (![self.indexs objectForKey:indexPath]) {
            [self.indexs setObject:[NSString stringWithFormat:@"%0.2f",cell.frame.size.height] forKey:indexPath];
        }
        
        return cell;
    }else{
        static NSString *itemIdentify = @"ItemCell";
        ItemCell *cell = (ItemCell *)[tableView dequeueReusableCellWithIdentifier:itemIdentify];
        if (cell == nil) {
            cell = [[ItemCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:itemIdentify];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            cell.delegate = self;
        }
        
        cell.info = [[self.result objectForKey:@"details"] objectAtIndex:indexPath.row - 1];
        if (![self.indexs objectForKey:indexPath]) {
            [self.indexs setObject:[NSString stringWithFormat:@"%0.2f",cell.frame.size.height] forKey:indexPath];
        }
        return cell;
    }
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.result) {
        return [[self.result objectForKey:@"details"] count] + 1;
    }else{
        return 0;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}





@end
