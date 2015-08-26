//
//  AreaView.h
//  angelslike
//
//  Created by angelslike on 15/8/26.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeaderDefiner.h"
#import "NetWork.h"

@interface AreaView : UIView<UIPickerViewDataSource,UIPickerViewDelegate>{
    UIToolbar *toolbar;
    UIPickerView *picker;
}


@property(nonatomic,strong) NSArray *pros;
@property(nonatomic,strong) NSDictionary *citys;
@property(nonatomic,strong) NSDictionary *areas;

-(void)show;

@end
