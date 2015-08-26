//
//  AddressCell.h
//  angelslike
//
//  Created by angelslike on 15/8/26.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeaderDefiner.h"

@interface AddressCell : UITableViewCell{
    UILabel *label;
    UITextField *_textField;
}

@property(nonatomic,strong) UITextField *textField;

@end
