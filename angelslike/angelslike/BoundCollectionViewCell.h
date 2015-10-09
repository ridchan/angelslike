//
//  BoundCollectionViewCell.h
//  angelslike
//
//  Created by angelslike on 15/10/9.
//  Copyright © 2015年 angelslike. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeaderDefiner.h"

@interface BoundCollectionViewCell : UICollectionViewCell{
    UIImageView *logo;
    UIImageView *imageView;
    UILabel *nameLbl;
    UILabel *priceLbl;
    UILabel *lbl1;
    UILabel *lbl2;
    UILabel *disLbl;
    UILabel *stockLbl;
    
    id tar;
    SEL act;
}

@property(nonatomic,strong) NSDictionary *info;

@end
