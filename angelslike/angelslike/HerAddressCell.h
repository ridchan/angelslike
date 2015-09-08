//
//  HerAddressCell.h
//  angelslike
//
//  Created by angelslike on 15/9/8.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CheckButton.h"
#import "HeaderDefiner.h"

@interface HerAddressCell : UITableViewCell{
    CheckButton *cb;
    UILabel *label;
    UILabel *desc;
}

@property(nonatomic) BOOL bCheck;

@end
