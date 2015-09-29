//
//  BoundView.h
//  angelslike
//
//  Created by angelslike on 15/9/29.
//  Copyright © 2015年 angelslike. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MutilePickerView.h"

@interface BoundView : UIView{
    MutilePickerView *mp;
}


@property(nonatomic,strong) NSMutableDictionary *info;



@end
