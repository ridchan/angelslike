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

@interface MyAddressCell : UITableViewCell{
    CheckButton *cb;
    UILabel *label;
}

@property(nonatomic) BOOL bCheck;

@end
