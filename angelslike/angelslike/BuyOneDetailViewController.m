//
//  BuyOneDetailViewController.m
//  angelslike
//
//  Created by angelslike on 15/10/9.
//  Copyright © 2015年 angelslike. All rights reserved.
//

#import "BuyOneDetailViewController.h"

@interface BuyOneDetailViewController ()

@end

@implementation BuyOneDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initailSetting];
    [self loadData];
    [self setBackButtonAction:@selector(backClick:)];
    [self addBottomButton];
    
    // Do any additional setup after loading the view.
}

-(void)backClick:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)initailSetting{
//    _scrollView = [[UIScrollView alloc]initWithFrame:RECT(0, 0, ScreenWidth, ScreenHeight)];
//    _scrollView.backgroundColor = HexColor(@"F1F0F6");
    self.result = [NSMutableArray array];
    _tableView = [[LoadMoreTableView alloc]initWithFrame:RECT(0, 0, ScreenWidth, ScreenHeight)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.currentPage = 0;
    [self.tableView addTarget:self action:@selector(loadRecords)];
    [self.view addSubview:_tableView];
    
    
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identify = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        cell.backgroundColor =  [UIColor clearColor];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    NSDictionary *dic = self.result[indexPath.row];
    cell.textLabel.text = [dic strForKey:@"name"];
    
    return cell;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  [self.result count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadData{
    __weak BuyOneDetailViewController *tempSelf =self;
    __weak LoadMoreTableView *tempTableView = _tableView;
    [[NetWork shared] query:BuyOneDetail info:@{@"id":self.strid} block:^(id Obj) {
        if ([Obj intForKey:@"status"] == 1){
            tempSelf.info = [Obj objectForKey:@"data"];
            tempTableView.tableHeaderView = [tempSelf headerView];
            
            
            [[NetWork shared] query:BuyingUrl info:@{@"id":[tempSelf.info strForKey:@"product"]} block:^(id Obj) {
                if ([Obj intForKey:@"status"] == 1){
                    [tempSelf.result addObjectsFromArray:[[Obj objectForKey:@"data"] objectForKey:@"list"]];
                    [tempSelf loadRecords];
                }
            } lock:NO];
        }

    } lock:YES];
    

}

-(void)loadRecords{
    
    NSString *npage = [NSString stringWithFormat:@"%d",(int)self.tableView.currentPage + 1];
    __weak BuyOneDetailViewController *tempSelf =self;
    [[NetWork shared] query:BuyingUrl info:@{@"id":[self.info strForKey:@"product"],@"page":npage} block:^(id Obj) {
        if ([Obj intForKey:@"status"] == 1){
            NSDictionary *pageInfo = [[Obj objectForKey:@"data"] objectForKey:@"pageinfo"];
            tempSelf.tableView.currentPage = [pageInfo intForKey:@"page"];
            tempSelf.tableView.totalPage = [pageInfo intForKey:@"maxpage"];
            [tempSelf.result addObjectsFromArray:[[Obj objectForKey:@"data"] objectForKey:@"list"]];
            [tempSelf.tableView loadDataEnd];
        }
    } lock:NO];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if ([self checkScrollView:scrollView]) {
        [self.tableView loadDataBegin];
    }
}

-(UIView *)headerView{
    UIView *view = [[UIView alloc]initWithFrame:RECT(0, 0, ScreenWidth, 1000)];
    view.clipsToBounds = YES;
    view.backgroundColor = [UIColor clearColor];
    RCWebView *webView = [[RCWebView alloc]initWithFrame:RECT(0, 0, ScreenWidth, 0)];
    webView.userInteractionEnabled = NO;
    [view addSubview:webView];
    
    
    
    UIView *anView = [self animationView:RECT(0, 0, ScreenWidth, 250)];
    [view addSubview:anView];
    [self runViewAnimation];
    
    BuyOneDetailView *bdv = [[BuyOneDetailView alloc]initWithFrame:RECT(0, 0, ScreenWidth, 250)];
    [view addSubview:bdv];
    
    webView.block = ^(id obj){
        anView.frame = RECT(0, [obj floatValue], ScreenWidth, 250);
        bdv.frame = RECT(0, MaxY(anView) + 50, ScreenWidth, 250);
        view.frame = RECT(0, 0, ScreenWidth, MaxY(bdv));
        [_tableView reloadData];
    };
    
    bdv.block = ^(id obj){
        view.frame = RECT(0, 0, ScreenWidth, [obj floatValue]);
        [_tableView reloadData];
    };
    
//    NSLayoutConstraint *l = [NSLayoutConstraint constraintWithItem:webView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeTop multiplier:1.0 constant:1.0];
//    
//    NSLayoutConstraint *l1 = [NSLayoutConstraint constraintWithItem:anView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:webView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:1.0];
//    
//    NSLayoutConstraint *l2 = [NSLayoutConstraint constraintWithItem:bdv attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:anView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:1.0];
//    [view addConstraints:@[l,l1,l2]];
//    
//    if (isIOS8){
//        l.active = YES;
//        l1.active = YES;
//        l2.active = YES;
//    }
    
    [webView setText:[self.info strForKey:@"desc"]];
    bdv.info = self.info;
    
    
    return view;
}



-(void)addBottomButton{
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight - 54, ScreenWidth, 54)];
    v.backgroundColor = [UIColor whiteColor];
    [v.layer addSublayer:[self lineLayer:CGPointMake(0, 0)]];
    
    RCRoundButton *b1 =  [RCRoundButton buttonWithType:UIButtonTypeCustom];
    b1.frame = CGRectMake(10, 10, ScreenWidth - 20 , 34);
    [b1 setBackgroundColor:[UIColor getHexColor:@"FAC116"]];
    [b1 setTitleShadowColor:[UIColor getHexColor:@"E4AD05"] forState:UIControlStateNormal];
//    [b1 addTarget:self action:@selector(:) forControlEvents:UIControlEventTouchUpInside];
 
    [b1 setTitle:@"立即抢购" forState:UIControlStateNormal];
    b1.titleLabel.font = FontWS(16);
    [v addSubview:b1];
    

    
    [self.view addSubview:v];
}

-(UIView *)animationView:(CGRect)rect{
    UIView *view = [[UIView alloc] initWithFrame:rect];
    view.backgroundColor = [UIColor whiteColor];
    
    UIView *scaleView = [[UIView alloc]initWithFrame:RECT((ScreenWidth - 250) / 2, 10, 250, 250)];
    scaleView.backgroundColor = [UIColor whiteColor];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:RECT(0, 10, 250, 250)];
    UIImageView *coverView = [[UIImageView alloc]initWithFrame:imageView.frame];
    coverView.image =  IMAGE(@"giftCover");
    UIImageView *borderView = [[UIImageView alloc]initWithFrame:imageView.frame];
    borderView.image =  IMAGE(@"product-box");
    
    [scaleView addSubview:imageView];
    [scaleView addSubview:borderView];
    [scaleView addSubview:coverView];
    
    [view addSubview:scaleView];
    
    tempCover = coverView;
    
    [imageView setPreImageWithUrl:[self.info strForKey:@"giftimg"] block:^(id Obj) {
        
    }];
    
    return view;
}

-(void)runViewAnimation{
    if (tempCover == nil) return;
    __block BuyOneDetailViewController *tempSelf = self;
    [UIView animateWithDuration:1.5 animations:^{
        tempCover.center = CGPointMake(tempCover.center.x - 200, tempCover.center.y);
        tempCover.alpha = 0;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1.0 animations:^{
            tempCover.center = CGPointMake(tempCover.center.x + 200, tempCover.center.y);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.7 animations:^{
                tempCover.alpha = 1.0;
            } completion:^(BOOL finished) {
                [tempSelf runViewAnimation];
            }];
        }];
    }];
    
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
