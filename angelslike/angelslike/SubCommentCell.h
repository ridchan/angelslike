//
//  SubCommentCell.h
//  angelslike
//
//  Created by angelslike on 15/9/15.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeaderDefiner.h"

@interface SubCommentCell : UITableViewCell{
    UIView *backView;
    UIImageView *imageView;
    UILabel *nameLabel;
    UILabel *dateLabel;
    UILabel *commentLabel;
}

@property(nonatomic,strong) NSDictionary *info;

@end
