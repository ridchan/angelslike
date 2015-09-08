//
//  CouNameCell.h
//  angelslike
//
//  Created by angelslike on 15/9/7.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeaderDefiner.h"

@interface CouNameCell : UITableViewCell{
    UIImageView *imageView;
    UILabel *name;
    UILabel *price;
}

@property(nonatomic,strong) NSMutableDictionary *info;

@end
