//
//  OrderDetailViewCell.h
//  angelslike
//
//  Created by angelslike on 15/9/10.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeaderDefiner.h"

@interface OrderDetailView : UIView{
    UILabel *order;
    UILabel *statu;
    UIImageView *imageView;
    UILabel *name;
    UILabel *price;
    UILabel *total;
    UILabel *qty;
    UILabel *time;
    UILabel *paytype;
}

@property(nonatomic,strong) NSDictionary *info;

@end
