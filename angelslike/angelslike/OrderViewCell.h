//
//  OrderViewCell.h
//  angelslike
//
//  Created by angelslike on 15/9/9.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeaderDefiner.h"
#import "OrderDetailViewCell.h"
#import "RCRoundButton.h"

@interface OrderViewCell : UITableViewCell<UITableViewDataSource,UITableViewDelegate>{
    UILabel *order;
    UILabel *statu;
    UIImageView *imageView;
    UILabel *name;
    UILabel *price;
    UILabel *total;
    UILabel *time;
    UILabel *paytype;
    
    UITableView *_tableView;
    
    RCRoundButton *payButton;
    RCRoundButton *detailButton;
}

@property(nonatomic,strong) NSDictionary *info;

@end
