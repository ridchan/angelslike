//
//  BuyNowViewController.h
//  angelslike
//
//  Created by ridchan on 15/8/26.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import "BaseViewController.h"

@interface BuyNowViewController : BaseViewController<UIPickerViewDataSource,UIPickerViewDelegate>

@property(nonatomic,strong) NSArray *pro;
@property(nonatomic,strong) NSArray *citys;
@property(nonatomic,strong) NSArray *dis;

@end
