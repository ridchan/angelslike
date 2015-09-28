//
//  MyAddressView.h
//  angelslike
//
//  Created by angelslike on 15/9/28.
//  Copyright © 2015年 angelslike. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CheckButton.h"
#import "HeaderDefiner.h"
#import "PickerView.h"
#import "NetWork.h"
#import "SGPopSelectView.h"
#import "MutilePickerView.h"

typedef void(^BasicBlock)(id obj);

@interface MyAddressView : UIView{
    CheckButton *cb;
    UILabel *label;
    SGPopSelectView *popView;
    MutilePickerView *mp;
}

@property(nonatomic) BOOL bCheck;

@property(nonatomic,strong) NSMutableDictionary *info;

@property(nonatomic,copy) BasicBlock block;

@end
