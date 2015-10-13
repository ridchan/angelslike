//
//  MyCollectViewController.h
//  angelslike
//
//  Created by angelslike on 15/10/13.
//  Copyright © 2015年 angelslike. All rights reserved.
//

#import "BaseViewController.h"
#import "ProductCell.h"
#import "MJRefresh.h"

@interface MyCollectViewController : BaseViewController<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>{
    NSInteger page;
    NSInteger totalPage;
    BOOL bloading ;
    UISearchBar *_searchBar;
}

@property(nonatomic,strong) UICollectionView *collectionView;
@property(nonatomic,strong) NSMutableArray *result;
@property(nonatomic,strong) NSMutableDictionary *info;
@property(nonatomic,strong) NSDictionary *dic;


@end
