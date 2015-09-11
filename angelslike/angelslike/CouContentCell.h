//
//  CouContentCell.h
//  angelslike
//
//  Created by angelslike on 15/9/7.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeaderDefiner.h"

@interface CouContentCell : UITableViewCell<UITextViewDelegate>{
    UITextView *_textView;
}
@property(nonatomic,weak) NSMutableDictionary *info;
@end
