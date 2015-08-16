//
//  CouDetailCell.h
//  angelslike
//
//  Created by angelslike on 15/8/13.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeaderDefiner.h"

@interface CouDetailCell : UITableViewCell{
    UIImageView *imageView;
    UILabel *nameLabel;
    UILabel *timeStartLabel;
    UILabel *timeEndLabel;
    UILabel *statuLabel;
    
    UILabel *targetLabel;
    UILabel *priceLabel;
    UILabel *totalLabel;
}

@property(nonatomic,strong) NSDictionary *info;

@end
