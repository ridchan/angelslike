//
//  ProductlistViewController.h
//  angelslike
//
//  Created by angelslike on 15/8/11.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import "BaseViewController.h"
#import "ProductCell.h"
#import "MJRefresh.h"
#import "ProductDetailViewController.h"
#import "MXPullDownMenu.h"

@interface ProductlistViewController : BaseViewController<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,MXPullDownMenuDelegate,UISearchBarDelegate>{
    NSInteger page;
    NSInteger totalPage;
    BOOL bloading ;
    MXPullDownMenu *downMenu;
    UISearchBar *_searchBar;
}

@property(nonatomic,strong) UICollectionView *collectionView;
@property(nonatomic,strong) NSMutableArray *result;
@property(nonatomic,strong) NSMutableDictionary *info;
@property(nonatomic,strong) NSDictionary *dic;


@end
