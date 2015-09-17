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
@interface MutilePickerView : UIView{
    SGPopSelectView *popView;
}


@property(nonatomic,strong) NSArray *items; //初始化选择
@property(nonatomic,strong) NSArray *keys;
@property(nonatomic,strong) NSMutableDictionary *result;//选择结果

@end
