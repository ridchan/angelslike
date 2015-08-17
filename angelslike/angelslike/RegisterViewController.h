//
//  RegisterViewController.h
//  angelslike
//
//  Created by angelslike on 15/8/10.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import "BaseViewController.h"
#import "TextFieldValidator.h"
#import "RCHub.h"

@interface RegisterViewController : BaseViewController<UITextFieldDelegate>{
    RCRoundButton *registButton;
}

@property(nonatomic,strong) NSArray *infos;

@end
