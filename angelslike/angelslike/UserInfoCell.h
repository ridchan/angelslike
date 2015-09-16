//
//  UserInfoCell.h
//  angelslike
//
//  Created by angelslike on 15/8/12.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeaderDefiner.h"
#import "UIImageView+WebCache.h"

@interface UserInfoCell : UITableViewCell{
    UIImageView *imageView;
    UIImageView *logo;
    UILabel *nameLabel;
    UILabel *moneyLabel;
    UILabel *depositLabel;
    
}


@property(nonatomic,strong) NSDictionary *info;
@property(nonatomic,strong) UIView *wallent;
@property(nonatomic,strong) UIButton *editButton;
-(UIImageView *)logo;

@end
