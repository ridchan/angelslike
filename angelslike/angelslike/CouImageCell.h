//
//  CouImageCell.h
//  angelslike
//
//  Created by angelslike on 15/9/7.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeaderDefiner.h"
#import "UIView+Controller.h"
#import "NetWork.h"


@interface ImageCell : UICollectionViewCell

@property(nonatomic,strong) UIImageView *imageView;

@end

@interface CouImageCell : UITableViewCell<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UIActionSheetDelegate>{
    UIImageView *imageView;
    UILabel *label;
    UICollectionView *_collectionView;
    NSInteger asIndex ;
    UIViewController *vc;
}

@property(nonatomic,strong) NSMutableArray *images;
@property(nonatomic,strong) NSMutableArray *imageNames;

@property(nonatomic,weak) NSMutableDictionary *info;

@end
