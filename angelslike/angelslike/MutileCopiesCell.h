//
//  MutileCopiesCell.h
//  angelslike
//
//  Created by angelslike on 15/9/8.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeaderDefiner.h"
#import "CheckButton.h"

@interface MutileCopiesCell : UITableViewCell{
    UILabel *label;
    UILabel *desc;
    CheckButton *cb;
}

@property(nonatomic) BOOL bCheck;

@end
