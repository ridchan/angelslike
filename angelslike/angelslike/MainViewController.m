//
//  MainViewController.m
//  angelslike
//
//  Created by angelslike on 15/8/4.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    scrolerHeight = ScreenWidth * 9 / 16;
    cellHeight = (ScreenWidth - MainCellMargin * 2) * 49 / 108 + MainCellGap; // 108:49
    
    [self initailNewSetting];
    
//    [self loadMoreData:nil];
    
    // Do any additional setup after loading the view.
}

-(void)refreshClick:(id)sender{
    [scroller start:SliderLink];
    [self loadMoreData:nil];
}

-(void)loadMoreData:(id)obj{
    __block MainViewController *tempSelf = self;
    NSString *nPage = [NSString stringWithFormat:@"%ld",(long)(self.tableView.currentPage + 1)];
    [[NetWork shared] startQuery:ListLink
                            info:@{@"page":nPage,@"sort":@"new"}
                   completeBlock:^(id Obj) {
                       [tempSelf  showNetworkError:[Obj intForKey:@"status"] == 0];
                       if ([Obj intForKey:@"status"] == 1) {
                           NSArray *rs = [[Obj objectForKey:@"data"] objectForKey:@"list"];
                           NSDictionary *pageInfo = [[Obj objectForKey:@"data"] objectForKey:@"pageinfo"];
                           tempSelf.cdn = img1Url;// [Obj objectForKey:@"cdn"];
                           if ([rs count] > 0){
                               tempSelf.tableView.totalPage = [[pageInfo objectForKey:@"maxpage"] integerValue];
                               tempSelf.tableView.currentPage = [[pageInfo objectForKey:@"page"] integerValue];
                               [tempSelf.result addObjectsFromArray:rs];
                               [tempSelf.tableView reloadData];
                           }
                       }
                       [tempSelf.tableView.header endRefreshing];
                       [tempSelf.tableView loadDataEnd];
    }];
}

-(void)initailSetting{
    self.navigationItem.title = @"天使礼客";
    self.result = [NSMutableArray array];
    self.tableView = [[LoadMoreTableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.currentPage = 0;
    self.tableView.totalPage = 0;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.tableView addTarget:self action:@selector(loadMoreData:)];
    [self.view addSubview:self.tableView];
    
    scroller =  [[ImageScroller alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenWidth * 0.45)];
    [scroller start:SliderLink];
    
    banner = [[Banner alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 60)];
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshClick:)];
//    [header setBackgroundColor:[UIColor getHexColor:@"ff6969"]];
    header.automaticallyChangeAlpha = YES;
    header.lastUpdatedTimeLabel.hidden = YES;
    self.tableView.header = header;
    
}

-(void)initailNewSetting{
    self.navigationItem.title = @"天使礼客";
    
    _scrollView =  [[UIScrollView alloc]initWithFrame:RECT(0, 0, ScreenWidth, ScreenHeight)];
    [self.view addSubview:_scrollView];
    
    scroller =  [[ImageScroller alloc]initWithFrame:RECT(0, 0, ScreenWidth, ScreenWidth * 0.45)];
//    [scroller start:SliderLink];
    [_scrollView addSubview:scroller];
    
    banner = [[Banner alloc]initWithFrame:RECT(0,MaxY(scroller), ScreenWidth, ScreenWidth / 4)];
    [_scrollView addSubview:banner];
    
    __block MainViewController *tempSelf = self;
    [[NetWork shared]query:@"http://app.angelslike.com/index/homeshow" info:nil block:^(id Obj) {
        if ([Obj intForKey:@"status"] == 1){
            
            tempSelf.infos = [Obj objectForKey:@"data"];
            
            scroller.infos = [tempSelf.infos objectForKey:@"slider"];
            [scroller startDownload];
            
            
        
            UIView *dv = [tempSelf dealView:RECT(0, MaxY(banner), ScreenWidth, 800)];
            [_scrollView addSubview:dv];
            UIView *bv = [tempSelf buyOneView:RECT(0, MaxY(dv), ScreenWidth, 800)];
            [_scrollView addSubview:bv];
            UIView *sv = [tempSelf bondedView:RECT(0, MaxY(bv), ScreenWidth, 800)];
            [_scrollView addSubview:sv];

            
            
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:RECT(0, MaxY(sv) + 10, ScreenWidth, ScreenWidth * 57 / 320)];
            imageView.image = IMAGE(@"home-end-bg");
            [_scrollView addSubview:imageView];
            _scrollView.contentSize = CGSizeMake(1, MaxY(imageView));
        }
    } lock:NO];
    
    

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark 自定义 Cell


-(void)viewClick:(NSDictionary *)dic{
    ProductDetailViewController *vc = [[ProductDetailViewController alloc]init];
    vc.info = dic;
    [self.navigationController pushViewController:vc animated:YES];
}


-(UIView *)dealView:(CGRect)rect{
    UIView *view = [[UIView alloc]initWithFrame:rect];
    
    UILabel *label  =  [[UILabel alloc]initWithFrame:RECT(10, 0, rect.size.width - 20, 30)];
//    label.textColor = RGBA(178,177,182,.9);
    label.textColor = HexColor(@"3c3c3c");
    label.font = FontWS(15);
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc]initWithString:@"限量特供 一折起"];
    [attrString addAttribute:NSFontAttributeName value:FontWS(12) range:NSMakeRange([@"限量特供 " length], [@"一折起" length])];
    [attrString addAttribute:NSForegroundColorAttributeName value:HexColor(@"808080") range:NSMakeRange([@"限量特供 " length], [@"一折起" length])];
    label.attributedText = attrString;
    [view addSubview:label];
    
    UILabel *label2  =  [[UILabel alloc]initWithFrame:RECT(10, 0, rect.size.width - 20, 30)];
    label2.textAlignment = NSTextAlignmentRight;
    label2.textColor = HexColor(@"AFAFAF");
    label2.font = FontWS(12);
    label2.text = @"厂家试用体验商品";
    [view addSubview:label2];
    
    [view addline:CGPointMake(0, 30) color:nil];
    
    NSArray *array = [self.infos objectForKey:@"discount"];
    CGFloat width = ScreenWidth  ;
    CGFloat height = 200;
    CGFloat y = MaxY(label) + 5;
    for (int i = 0 ; i < [array count] ; i ++ ){
        DealView *dv = [[DealView alloc]initWithFrame:RECT(0, y + 5  , width, height)];
        dv.type = CellType_Deal;
        dv.info = [array objectAtIndex:i];
        [dv addTarget:self action:@selector(viewClick:)];
        [view addSubview:dv];
        y = MaxY(dv);
    }
    
    UIButton *moreButton = [self buttonWithFrame:RECT(rect.size.width - 60, y, 50, 30)];
    [view addSubview:moreButton];
    
    view.frame = RECT(rect.origin.x, rect.origin.y, rect.size.width, MaxY(moreButton));
    
    NSArray *advs = [self.infos objectForKey:@"advert"];
    if ([advs count] > 1) {
        NSDictionary *dic = advs[1];
        UIImageView *imageView = [self adverImageView:RECT(0, MaxY(moreButton), ScreenWidth, ScreenWidth * 5 / 32) url:[dic strForKey:@"img"]];
        [view addSubview:imageView];
        
        view.frame = RECT(rect.origin.x, rect.origin.y, rect.size.width, MaxY(imageView));
    }
    return view;
}




-(UIView *)buyOneView:(CGRect)rect{
    UIView *view = [[UIView alloc]initWithFrame:rect];
    
    UILabel *label  =  [[UILabel alloc]initWithFrame:RECT(10, 0, rect.size.width - 20, 30)];
    label.textColor = HexColor(@"3c3c3c");
    label.font = FontWS(15);
    label.text = @"买一送一";
    [view addSubview:label];
    
    [view addline:CGPointMake(0, 30) color:nil];
    
    NSArray *array = [self.infos objectForKey:@"buyone"];
    CGFloat width = ScreenWidth / 2 - 15;
    CGFloat height = 230;
    
    CGFloat y = 0;
    for (int i = 0 ; i < [array count] ; i ++ ){
        int row = floorf(i / 2);
        int column = i  - row * 2;
        
        
        DealView *dv = [[DealView alloc]initWithFrame:RECT(10 + (10 + width) * column, MaxY(label) + 10 + (10 + height) * row  , width, height)];
        dv.type = CellType_BuyOne;
        dv.info = [array objectAtIndex:i];
        [dv addTarget:self action:@selector(viewClick:)];
        [view addSubview:dv];
        y = MaxY(dv);
    }
    
    UIButton *moreButton = [self buttonWithFrame:RECT(rect.size.width - 60, y, 50, 30)];
    [view addSubview:moreButton];
    
    view.frame = RECT(rect.origin.x, rect.origin.y, rect.size.width, MaxY(moreButton));
    
    NSArray *advs = [self.infos objectForKey:@"advert"];
    if ([advs count] > 2) {
        NSDictionary *dic = advs[2];
        UIImageView *imageView = [self adverImageView:RECT(0, MaxY(moreButton), ScreenWidth, ScreenWidth * 5 / 32) url:[dic strForKey:@"img"]];
        [view addSubview:imageView];
        
        view.frame = RECT(rect.origin.x, rect.origin.y, rect.size.width, MaxY(imageView));
    }
    return view;
}

-(UIView *)bondedView:(CGRect)rect{
    UIView *view = [[UIView alloc]initWithFrame:rect];
    
    UILabel *label  =  [[UILabel alloc]initWithFrame:RECT(10, 0, rect.size.width - 20, 30)];
    label.textColor = HexColor(@"3c3c3c");
    label.font = FontWS(15);
    label.text = @"海关保税仓直供";
    [view addSubview:label];
    
    [view addline:CGPointMake(0, 30) color:nil];
    
    UIView *notifyView =[self notifyView:RECT(0, MaxY(label) + 10, ScreenWidth, 19 * ScreenWidth  / 320)];
    [view addSubview:notifyView];
    
    NSArray *array = [self.infos objectForKey:@"bonded"];
    CGFloat width = ScreenWidth / 2 - 15;
    CGFloat height = 230;
    
    CGFloat y =  0;
    for (int i = 0 ; i < [array count] ; i ++ ){
        int row = floorf(i / 2);
        int column = i  - row * 2;
        
        
        DealView *dv = [[DealView alloc]initWithFrame:RECT(10 + (10 + width) * column, MaxY(notifyView) + 10 + (10 + height) * row  , width, height)];
        dv.type = CellType_Bound;
        dv.info = [array objectAtIndex:i];
        [dv addTarget:self action:@selector(viewClick:)];
        [view addSubview:dv];
        y = MaxY(dv);
    }
    
    UIButton *moreButton = [self buttonWithFrame:RECT(rect.size.width - 60, y, 50, 30)];
    [view addSubview:moreButton];
    
    view.frame = RECT(rect.origin.x, rect.origin.y, rect.size.width, MaxY(moreButton));
    
    NSArray *advs = [self.infos objectForKey:@"advert"];
    if ([advs count] > 0) {
        NSDictionary *dic = advs[0];
        UIImageView *imageView = [self adverImageView:RECT(0, MaxY(moreButton), ScreenWidth, ScreenWidth * 5 / 32) url:[dic strForKey:@"img"]];
        [view addSubview:imageView];
        
        view.frame = RECT(rect.origin.x, rect.origin.y, rect.size.width, MaxY(imageView));
    }
    
    
    
    return view;
}

-(UIImageView *)notifyView:(CGRect)rect{
//    UIView *view = [[UIView alloc]initWithFrame:rect];
//    view.backgroundColor = [UIColor whiteColor];
//    
//    CGFloat width = rect.size.width / 4;
//    NSArray *titles = @[@"合法报关",@"检疫检验",@"保税仓直供",@"品质保证"];
//    NSArray *imgs = @[@"bonded2",@"inspection",@"legal",@"security"];
//    
//    for (int i = 0 ; i < [titles count] ; i ++){
//        UIImageView *imageView =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 35, 35)];
//        imageView.center = CGPointMake(width * i + width / 2, rect.size.height / 2 - 5);
//        imageView.image = IMAGE(imgs[i]);
//        
//        UILabel *label = [[UILabel alloc]initWithFrame:RECT(width * i, MaxY(imageView), width, 14)];
//        label.textAlignment = NSTextAlignmentCenter;
//        label.font = FontWS(12);
//        
//        label.text = titles[i];
//        [view addSubview:imageView];
//        [view addSubview:label];
//    }
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:rect];
    imageView.image = IMAGE(@"page1");
    return imageView;
}

-(UIImageView *)adverImageView:(CGRect)rect url:(NSString *)url{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:rect];
    [imageView setPreImageWithUrl:url];
    return imageView;
}

-(UIButton *)buttonWithFrame:(CGRect)rect{
    UIButton *moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [moreButton setTitle:@"更多" forState:UIControlStateNormal];
    moreButton.titleLabel.font = FontWS(13);
    moreButton.frame = rect;
    [moreButton setTitleColor:HexColor(@"7c7c7c") forState:UIControlStateNormal];
    
    return moreButton;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark -
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row > 1) {
        NSDictionary *info = [self.result objectAtIndex:indexPath.row - 2];
        ThemeDetailViewController *vc = [[ThemeDetailViewController alloc]init];
//        vc.hidesBottomBarWhenPushed = YES;
        vc.strid = [info strForKey:@"id"];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Slider"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Slider"];
            [cell addSubview:scroller];
            cell.backgroundColor =  [UIColor clearColor];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        }

        return cell;
    }else if (indexPath.row == 1){
        UITableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:@"Banner"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Banner"];
            [cell addSubview:banner];
            cell.backgroundColor =  [UIColor clearColor];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        }
        
        return cell;
        
    }else{
        static NSString *identify = @"Cell";
        MainCell *cell = (MainCell *)(MainCell *)[tableView dequeueReusableCellWithIdentifier:identify];
        if (cell == nil) {
            cell = [[MainCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
            cell.backgroundColor =  [UIColor clearColor];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        }
        
        NSDictionary *info = [self.result objectAtIndex:indexPath.row - 2];
        NSString *link = [self.cdn stringByAppendingPathComponent:[info objectForKey:@"img"]];
        [cell setImageView:link];
        [cell setName:[info objectForKey:@"title"]];
        return cell;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  [self.result count] == 0?0:[self.result count] + 2;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return ScreenWidth * 0.45 ;// banner  16:9
    }else if(indexPath.row == 1) {
        return 70;
    }else{
        return cellHeight ;
    }
}



@end
