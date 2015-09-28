//
//  HerAddressView.h
//  angelslike
//
//  Created by angelslike on 15/9/28.
//  Copyright © 2015年 angelslike. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CheckButton.h"
#import "HeaderDefiner.h"

typedef void(^BasicBlock)(id obj);

@interface HerAddressView : UIView{
    CheckButton *cb;
    UILabel *label;
    UILabel *desc;
}

@property(nonatomic) BOOL bCheck;

@property(nonatomic,copy) BasicBlock block;

@end
