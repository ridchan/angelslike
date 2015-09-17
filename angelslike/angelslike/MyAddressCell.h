//
//  MyAddressCell.h
//  angelslike
//
//  Created by angelslike on 15/9/8.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CheckButton.h"
#import "HeaderDefiner.h"
#import "PickerView.h"
#import "NetWork.h"
#import "SGPopSelectView.h"
#import "MutilePickerView.h"

@interface MyAddressCell : UITableViewCell{
    CheckButton *cb;
    UILabel *label;
    SGPopSelectView *popView;
    MutilePickerView *mp;
}

@property(nonatomic) BOOL bCheck;

@property(nonatomic,strong) NSMutableDictionary *info;

@end
