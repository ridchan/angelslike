//
//  MutilePickerView.h
//  angelslike
//
//  Created by angelslike on 15/9/17.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PickerView.h"
#import "NetWork.h"
#import "SGPopSelectView.h"
#import "objc/runtime.h"

@interface MutilePickerView : UIView<UITableViewDataSource,UITableViewDelegate>{
    SGPopSelectView *popView;
    UITableView *_tableView;
    UIView *_tbView;
}


@property(nonatomic,strong) NSArray *items; //初始化选择
@property(nonatomic,strong) NSArray *keys;
@property(nonatomic,strong) NSMutableDictionary *result;//选择结果


@end
