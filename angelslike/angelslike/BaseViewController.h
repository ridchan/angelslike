//
//  BaseViewController.h
//  angelslike
//
//  Created by angelslike on 15/8/6.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColor+HexColor.h"
#import "HeaderDefiner.h"
#import "NetWork.h"

@interface BaseViewController : UIViewController

-(void)setTextFieldAttribute:(UITextField *)textField img:(NSString *)imgName bottom:(BOOL)bottom;

-(CAShapeLayer *)createBound:(CGRect)rect bottom:(BOOL)bottom;

@end
