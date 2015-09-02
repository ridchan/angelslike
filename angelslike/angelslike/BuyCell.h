//
//  BuyCell.h
//  angelslike
//
//  Created by angelslike on 15/8/26.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeaderDefiner.h"
#import "QtyButton.h"

@interface BuyCell : UITableViewCell{
    UIImageView *imageView;
    UILabel *nameLabel;
    UILabel *qtyLabel;
    UILabel *totalLabel;
    UILabel *qty;
    QtyButton *qb;
}

@property(nonatomic,strong) NSMutableDictionary *info;

@end
