//
//  TopCell.h
//  angelslike
//
//  Created by angelslike on 15/8/27.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeaderDefiner.h"

@interface TopCell : UITableViewCell{
    UIImageView *imageView;
    UILabel *content;
    UIImageView *left;
    UIImageView *right;
}

-(void)setContent:(NSString *)text image:(NSString *)link;

@end
