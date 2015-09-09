//
//  ValDayCell.h
//  angelslike
//
//  Created by angelslike on 15/9/8.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeaderDefiner.h"
#import "UIView+Controller.h"
#import "PickerView.h"
#import "SGPopSelectView.h"

@interface ValDayCell : UITableViewCell{
    UILabel *label;
    UITextField *textField;
    PickerView *picker;
}



@end
