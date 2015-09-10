//
//  CouDetailViewController.h
//  angelslike
//
//  Created by angelslike on 15/8/12.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "CouDetail.h"
#import "CouPay.h"
#import "ProductDetailViewController.h"
#import "CommentViewController.h"
#import "CouRecordsViewController.h"

@interface CouDetailViewController : BaseViewController<UIScrollViewDelegate,CouDetailDelegate>{
    CouPay *cp;
    RCMutileView *mv;
}

@property(nonatomic,strong) NSDictionary *info;

@property(nonatomic,strong) UITableView *tableView;

@property(nonatomic,strong) NSDictionary *result;

@end
