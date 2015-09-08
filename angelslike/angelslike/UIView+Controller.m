//
//  UIView+Controller.m
//  angelslike
//
//  Created by angelslike on 15/9/8.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import "UIView+Controller.h"

@implementation UIView (Controller)

- (UIViewController *)findViewController:(UIView *)sourceView
{
    id target=sourceView;
    while (target) {
        target = ((UIResponder *)target).nextResponder;
        if ([target isKindOfClass:[UIViewController class]]) {
            break;
        }
    }
    return target;
}


@end
