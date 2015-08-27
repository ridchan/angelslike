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
    [self loadData];
    
}

-(void)topCellChange:(NSNotification *)obj{
//    UITableViewCell *cell = (UITableViewCell *)obj.object;
//    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
//    if(indexPath){
//        [self.indexs setObject:[NSString stringWithFormat:@"%0.2f",cell.frame.size.height] forKey:indexPath];
//        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
//    }
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
