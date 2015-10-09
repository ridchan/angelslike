//
//  BoundsViewController.h
//  angelslike
//
//  Created by angelslike on 15/10/9.
//  Copyright © 2015年 angelslike. All rights reserved.
//

#import "BaseViewController.h"
#import "MJRefresh.h"
#import "BoundCollectionViewCell.h"
#import "ProductDetailViewController.h"

@interface BoundsViewController : BaseViewController<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>{
    NSInteger page;
    NSInteger totalPage;
    BOOL bloading ;
}

@property(nonatomic,strong) UICollectionView *collectionView;
@property(nonatomic,strong) NSMutableArray *result;

@end
