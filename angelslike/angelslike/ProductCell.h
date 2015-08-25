//
//  ProductCell.h
//  angelslike
//
//  Created by angelslike on 15/8/19.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeaderDefiner.h"

@interface ProductCell : UICollectionViewCell{
    UIImageView *imageView;
    UILabel *nameLabel;
    UILabel *priceLabel;
}

@property(nonatomic,strong) NSDictionary *info;

@end
