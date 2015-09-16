//
//  PayRecordCell.h
//  angelslike
//
//  Created by angelslike on 15/9/15.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeaderDefiner.h"

@interface PayRecordCell : UITableViewCell{
    UILabel *lbl1;
    UILabel *lbl2;
    UILabel *lbl3;
    UILabel *lbl4;
    UILabel *lbl5;
}

@property(nonatomic,strong) NSDictionary *info;

@end
