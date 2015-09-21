//
//  PayCell.h
//  angelslike
//
//  Created by angelslike on 15/8/26.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeaderDefiner.h"

@interface PayCell : UITableViewCell

@property(nonatomic) NSInteger selectIndex;

@property(nonatomic,weak) NSMutableDictionary *info;

@end
