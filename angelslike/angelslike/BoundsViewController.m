//
//  BoundsViewController.m
//  angelslike
//
//  Created by angelslike on 15/10/9.
//  Copyright © 2015年 angelslike. All rights reserved.
//

#import "BoundsViewController.h"

@interface BoundsViewController ()

@end

@implementation BoundsViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    [self initailSetting];
    
}

-(void)initailSetting{
    self.navigationItem.title = @"保税商品";
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource  = self;

    
    [self.collectionView registerClass:[BoundCollectionViewCell class] forCellWithReuseIdentifier:@"BoundCell"];
    [self.view addSubview:self.collectionView];
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshClick:)];
    
    header.automaticallyChangeAlpha = YES;
    header.lastUpdatedTimeLabel.hidden = YES;
    self.collectionView.header = header;
    

    
    
    [self setBackButtonAction:@selector(backClick:)];
    
    self.result = [NSMutableArray array];
    page =  1;

    
    
    [self refreshClick:nil];
    
    

    
    bloading = NO;
    
}

-(void)backClick:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)loadData:(id)sender{
    __block BoundsViewController *tempSelf = self;
    
    [[NetWork shared]query:MPUrl info:@{@"type":@"home_list_bonded",@"page":[NSString stringWithFormat:@"%d",(int)page]} block:^(id Obj) {
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
    [self.result removeAllObjects];
    [self.collectionView reloadData];
    [self loadData:nil];
}


#pragma mark -
#pragma mark  collection view

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if([self checkScrollView:scrollView]){
        if (page < totalPage & bloading  == NO) {
            bloading = YES;
            page ++;
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
    
    BoundCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"BoundCell" forIndexPath:indexPath];
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
    return CGSizeMake(150, 205);
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 5;// ScreenWidth/9;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section;
{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
