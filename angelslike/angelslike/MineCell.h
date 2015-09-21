//
//  MineCell.h
//  angelslike
//
//  Created by angelslike on 15/8/7.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeaderDefiner.h"

@interface MineCell : UITableViewCell{
    UIImageView *imageView;
    UILabel *label;
}

@property(nonatomic,strong) NSDictionary *info;

@end
