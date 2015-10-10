//
//  MineViewController.h
//  angelslike
//
//  Created by angelslike on 15/8/7.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import "BaseViewController.h"
#import "MineCell.h"
#import "UserInfoCell.h"
#import "UserInfo.h"
#import "WXApi.h"
#import "SettingViewController.h"
#import "MyCouViewController.h"
#import "AddressViewController.h"
#import "OrderListViewController.h"
#import "MyWallentViewController.h"
#import "EditInfoViewController.h"
#import "MyGiftViewController.h"

@interface MineViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>{
    NSInteger sheetIndex;
    UIImageView *userImg;
}


@property(nonatomic,strong) UITableView *tableView;

@property(nonatomic,strong) NSArray *infos;

@end
