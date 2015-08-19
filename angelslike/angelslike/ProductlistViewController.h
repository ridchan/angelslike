//
//  ProductlistViewController.h
//  angelslike
//
//  Created by angelslike on 15/8/11.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import "BaseViewController.h"
#import "ProductCell.h"

@interface ProductlistViewController : BaseViewController<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property(nonatomic,strong) UICollectionView *collectionView;
@property(nonatomic,strong) NSMutableArray *result;

@end
