//
//  PayNowViewController.h
//  angelslike
//
//  Created by angelslike on 15/9/23.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import "BaseViewController.h"
#import "PayCell.h"
#import "WeiXinPayObj.h"
#import "AliPayObj.h"


@interface PayNowViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>{
    UITableView *_tableView;
}

@property(nonatomic,strong) NSString *orderid;
@property(nonatomic,strong) NSString *price;


@end
