//
//  BuyOneDetailViewController.m
//  angelslike
//
//  Created by angelslike on 15/10/9.
//  Copyright © 2015年 angelslike. All rights reserved.
//

#import "BuyOneDetailViewController.h"
#import "ProductRecordCell.h"
#import "CouDetail.h"

@interface BuyOneDetailViewController ()<BuyOneDetailDelegate>

@end

@implementation BuyOneDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initailSetting];
    [self loadData];
    [self addBottomButton];
    
    // Do any additional setup after loading the view.
}


-(void)initailSetting{
    
    self.result = [NSMutableArray array];
    _tableView = [[LoadMoreTableView alloc]initWithFrame:RECT(0, 0, ScreenWidth, ScreenHeight - 54)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.currentPage = 0;
    [self.tableView addTarget:self action:@selector(loadRecords)];
    [self.view addSubview:_tableView];
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 62;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identify = @"Cell";
    ProductRecordCell *cell = (ProductRecordCell *)[tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[ProductRecordCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    cell.info = self.result[indexPath.row];
    
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
    
    [[NetWork shared] query:BuyOneDetail info:@{@"id":self.strid} block:^(id Obj) {
        if ([Obj intForKey:@"status"] == 1){
            tempSelf.info = [Obj objectForKey:@"data"];
            
            [tempSelf setHeaderView];
            [tempSelf setFooterView];
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
        }
        [tempSelf.tableView reloadData];
        [tempSelf.tableView loadDataEnd];
    } lock:NO];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if ([self checkScrollView:scrollView]) {
        [self.tableView loadDataBegin];
    }
}

-(void)checkButtonClick:(id)sender{
    
}

-(void)setHeaderView{
    UIView *view = [[UIView alloc]initWithFrame:RECT(0, 0, ScreenWidth, 1500)];
    view.clipsToBounds = YES;
    view.backgroundColor = [UIColor clearColor];
    RCWebView *webView = [[RCWebView alloc]initWithFrame:RECT(0, 0, ScreenWidth, 0)];
    webView.userInteractionEnabled = NO;
    [view addSubview:webView];
    
    
    
    UIView *anView = [self animationView:RECT(0, 0, ScreenWidth, 250)];
    [view addSubview:anView];
    [self runViewAnimation];
    
    BuyOneDetailView *bdv = [[BuyOneDetailView alloc]initWithFrame:RECT(0, 0, ScreenWidth, 270)];
    bdv.delegate = self;
    [view addSubview:bdv];
    
    
    __block BuyOneDetailViewController *tempSelf = self;
    __block UIView *tempAnView = anView;
    __block BuyOneDetailView *tempBDV = bdv;
    __block UIView *tempView = view;
    __block UITableView *tempTableView = _tableView;
    
    webView.block = ^(id obj){
        tempAnView.frame = RECT(0, [obj floatValue], ScreenWidth, tempAnView.frame.size.height);
        tempBDV.frame = RECT(0, MaxY(tempAnView) + 10, ScreenWidth, tempBDV.frame.size.height);
        
        tempBDV.block = ^(id obj){
            tempView.frame = RECT(0, 0, ScreenWidth, MaxY(tempBDV) + 10);
            tempTableView.tableHeaderView = tempView;
        };
        
        tempBDV.info = tempSelf.info;
    };
    [webView setText:[self.info strForKey:@"desc"]];
    
}

-(void)setFooterView{
    UIView *view = [[UIView alloc]initWithFrame:RECT(0, 0, ScreenWidth, 80)];
    view.clipsToBounds = YES;
    view.backgroundColor = [UIColor whiteColor];
    
    IconView *icview = [[IconView alloc]initWithFrame:RECT(0, 0, ScreenWidth, 40)];
    [icview setFavitor:@"22" share:@"33" views:@"44"];
    [view addSubview:icview];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = RECT(0, 40, ScreenWidth, 40);
    button.titleLabel.textAlignment = NSTextAlignmentLeft;
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setBackgroundColor:HexColor(@"f1f1f7")];
    [button setTitle:@"往期产品" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(oldProductClick:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    
    self.tableView.tableFooterView = view;

}

-(void)oldProductClick:(id)sender{
    
}


-(void)addBottomButton{
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight - 54, ScreenWidth, 54)];
    v.backgroundColor = [UIColor whiteColor];
    [v.layer addSublayer:[self lineLayer:CGPointMake(0, 0)]];
    
    RCRoundButton *b1 =  [RCRoundButton buttonWithType:UIButtonTypeCustom];
    b1.frame = CGRectMake(10, 10, ScreenWidth - 20 , 34);
    [b1 setBackgroundColor:RGBA(248, 92, 133, 1)];
    
//    [b1 setTitleShadowColor:[UIColor getHexColor:@"E4AD05"] forState:UIControlStateNormal];
//    [b1 addTarget:self action:@selector(:) forControlEvents:UIControlEventTouchUpInside];
 
    [b1 setTitle:@"立即抢购" forState:UIControlStateNormal];
    b1.titleLabel.font = FontWS(16);
    [v addSubview:b1];
    

    
    [self.view addSubview:v];
}

-(UIView *)animationView:(CGRect)rect{
    UIView *view = [[UIView alloc] initWithFrame:rect];
    view.clipsToBounds = YES;
    view.backgroundColor = [UIColor whiteColor];
    
    UIView *scaleView = [[UIView alloc]initWithFrame:RECT((ScreenWidth - 250) / 2, 10, 250, 250)];
    scaleView.backgroundColor = [UIColor whiteColor];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:RECT(0, 0, 250, 250)];
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
    view.frame = ResizeHeight(view, MaxY(scaleView) + 10);
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
