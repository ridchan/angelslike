//
//  EditInfoViewController.h
//  angelslike
//
//  Created by angelslike on 15/9/16.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import "BaseViewController.h"
#import "PickerView.h"
#import "SGPopSelectView.h"

@interface EditInfoViewController : BaseViewController{
    UITextField *nametxt;
    UITextField *detailtxt;
    UITextField *phonetxt;
    
    UITextField *newpass;
    UITextField *comfirmpass;
    
    SGPopSelectView *popView;
}

@property(nonatomic,strong) NSMutableDictionary *info;


@end
