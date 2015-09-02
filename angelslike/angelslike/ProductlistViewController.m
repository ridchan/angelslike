//
//  ProductlistViewController.m
//  angelslike
//
//  Created by angelslike on 15/8/11.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import "ProductlistViewController.h"

@implementation ProductlistViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    [self initailSetting];
    
}

-(void)initailSetting{
    self.navigationItem.title = @"产品列表";
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource  = self;

    [self.collectionView registerClass:[ProductCell class] forCellWithReuseIdentifier:@"ProductCell"];
    [self.view addSubview:self.collectionView];
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshClick:)];

    header.automaticallyChangeAlpha = YES;
    header.lastUpdatedTimeLabel.hidden = YES;
    self.collectionView.header = header;
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 25, 25);
    [button setImage:[UIImage imageNamed:@"iconfont-houtui"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(backClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = barItem;
    
    self.result = [NSMutableArray array];
    page =  1;
    self.info = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                 [self.dic strForKey:@"ID"],@"id",
                 [self.dic strForKey:@"Type"],@"type",
                 [NSString stringWithFormat:@"%ld",page],@"page",
                 nil];
    
    bloading = NO;
    [self refreshClick:nil];
}

-(void)loadData:(id)sender{
    __block ProductlistViewController *tempSelf = self;
    
    
    [[NetWork shared]query:ProductsUrl info:self.info block:^(id Obj) {
        [tempSelf showNetworkError:[Obj intForKey:@"status"] == 0];
        
        if ([Obj intForKey:@"status"] == 1) {
            NSArray *rs = [[Obj objectForKey:@"data"] objectForKey:@"list"];
            NSDictionary *pageInfo = [[Obj objectForKey:@"data"] objectForKey:@"pageinfo"];
            if ([rs count] > 0){
                totalPage = [[pageInfo objectForKey:@"maxpage"] integerValue];
                page = [[pageInfo objectForKey:@"page"] integerValue];
                [tempSelf.result addObjectsFromArray:rs];
                [self.collectionView reloadData];
            }
            bloading = NO;
            
        }
        
        [self.collectionView.header endRefreshing];
    } lock:NO];
}

-(void)refreshClick:(id)sender{
    [self.info setObject:@"1" forKey:@"page"];
    [self.result removeAllObjects];
    [self loadData:nil];
}

-(void)backClick:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark- Source Delegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if( scrollView.contentOffset.y > ((scrollView.contentSize.height - scrollView.frame.size.height - 20))){
        if (page < totalPage & bloading  == NO) {
            bloading = YES;
            [self.info setObject:[NSString stringWithFormat:@"%ld",page + 1] forKey:@"page"];
//            NSLog(@"self.info %@",self.info);
            [self loadData:nil];
        }
    }
}


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return  ceilf([self.result count] / 2);
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if ((section + 1) * 2 > [self.result count ] ) {
        return 1;
    }else{
        return 2;
    }
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ProductCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"ProductCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    NSDictionary *p = [self.result objectAtIndex:indexPath.section * 2 + indexPath.row];
    [cell setInfo:p];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *p = [self.result objectAtIndex:indexPath.section * 2 + indexPath.row];
    ProductDetailViewController *vc = [[ProductDetailViewController alloc]init];
    vc.info = p;
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark- FlowDelegate
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(150, 150);
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 5;// ScreenWidth/9;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section;
{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}






@end
