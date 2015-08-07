//
//  CouCell.h
//  angelslike
//
//  Created by angelslike on 15/8/6.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HeaderDefiner.h"
#import "UIImageView+WebCache.h"
#import "UIColor+HexColor.h"

@interface CouCell : UITableViewCell{
    UIImageView *imageView;//图片
    UILabel *companyLabel;//图片名称
    UILabel *nameLabel;//目标名称
    UILabel *pnameLabel;//描述
    UILabel *dayLabel;//价格 ，剩余
    UILabel *targetLabel;//凑目标
    UILabel *statuLabel;
    UIView *progress;
    UIView *bg;
    
}

@property(nonatomic,strong) NSDictionary *info;

@end
