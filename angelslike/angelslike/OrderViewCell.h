//
//  OrderViewCell.h
//  angelslike
//
//  Created by angelslike on 15/9/9.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeaderDefiner.h"
#import "OrderDetailView.h"
#import "RCRoundButton.h"

typedef enum{
    OrderCellType_Pay = 1,
    OrderCellType_Detail = 2
}OrderCellType;

@interface OrderViewCell : UITableViewCell{
    UILabel *order;
    UILabel *statu;
    UIImageView *imageView;
    UILabel *name;
    UILabel *price;
    UILabel *total;
    UILabel *time;
    UILabel *paytype;
    
    UIView *_tableView;
    
    RCRoundButton *payButton;
    RCRoundButton *detailButton;
    
    id tar;
    SEL act;
}

@property(nonatomic,strong) NSDictionary *info;

-(void)addTarget:(id)target action:(SEL)action;

@end
