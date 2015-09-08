//
//  CouMyQtyCell.h
//  angelslike
//
//  Created by angelslike on 15/9/7.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QtyButton.h"

@interface CouMyQtyCell : UITableViewCell{
    QtyButton *qb;
    UILabel *label;
}

@property(nonatomic,strong) NSMutableDictionary *info;

@end
