//
//  AddressViewController.h
//  angelslike
//
//  Created by angelslike on 15/9/1.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import "BaseViewController.h"
#import "MineView.h"
#import "HerView.h"
#import "CircleButton.h"

@interface AddressViewController : BaseViewController{
    MineView *mv;
    HerView *hv;
    CircleButton *cb;
    BOOL bCenter;
}

@end
