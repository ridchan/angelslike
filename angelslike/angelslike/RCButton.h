//
//  RCButton.h
//  angelslike
//
//  Created by angelslike on 15/10/9.
//  Copyright © 2015年 angelslike. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ButtonBlock)(id obj);

@interface RCButton : UIButton

@property(nonatomic,copy) ButtonBlock block;

@end
