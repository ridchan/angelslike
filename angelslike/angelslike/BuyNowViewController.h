//
//  BuyNowViewController.h
//  angelslike
//
//  Created by ridchan on 15/8/26.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import "BaseViewController.h"
#import "AreaView.h"
#import "HeaderDefiner.h"
#import "BuyCell.h"
#import "AddressCell.h"
#import "PayCell.h"
#import "MyAddressCell.h"
#import "HerAddressCell.h"
#import <AlipaySDK/AlipaySDK.h> 

@interface BuyNowViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>{
    AreaView *av;
    UILabel *totalLabel;
    NSUInteger addSelect;
}


@property(nonatomic,strong) UITableView *tableView;

@property(nonatomic,strong) NSMutableArray *products;

@property(nonatomic,strong) NSMutableArray *adds;

@property(nonatomic,strong) NSMutableArray *paytypes;

@property(nonatomic,strong) NSMutableDictionary *addInfo;

@end
