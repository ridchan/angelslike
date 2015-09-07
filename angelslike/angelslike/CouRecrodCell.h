//
//  CouRecrodCell.h
//  angelslike
//
//  Created by angelslike on 15/9/7.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeaderDefiner.h"
#import "ReplayView.h"

@interface CouRecrodCell : UITableViewCell{
    UIView *backView;
    UIImageView *imageView;
    UILabel *nameLabel;
    UILabel *dateLabel;
    UILabel *commentLabel;
    
    UILabel *qtylabel;
    UILabel *pricelabel;
    
    ReplayView *r1;
    ReplayView *r2;
}

@property(nonatomic,strong) NSDictionary *info;

@end
