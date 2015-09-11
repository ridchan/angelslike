//
//  StartCouViewViewController.h
//  angelslike
//
//  Created by angelslike on 15/9/7.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import "BaseViewController.h"
#import "CouNameCell.h"
#import "CouTitleCell.h"
#import "CouContentCell.h"
#import "CouImageCell.h"
#import "CouQtyCell.h"
#import "CouMyQtyCell.h"
#import "SGPopSelectView.h"
#import "MyAddressCell.h"
#import "HerAddressCell.h"
#import "OpenCell.h"
#import "MutileCopiesCell.h"
#import "Order.h"
#import "DataSigner.h"
#import "APAuthV2Info.h"
#import <AlipaySDK/AlipaySDK.h>

@interface StartCouViewViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>{
    SGPopSelectView *popView;
}


@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) NSMutableArray *infos;
@property(nonatomic,strong) NSMutableDictionary *P;

@end
