//
//  MainCell.h
//  angelslike
//
//  Created by angelslike on 15/8/4.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetWork.h"
#import "UIImageView+WebCache.h"


@interface MainCell : UITableViewCell{
    UIImageView *imageView;
    UILabel *nameLabel;
    CAGradientLayer *layer;
}

-(void) setImageView:(NSString *)link;
-(void) setName:(NSString *)name;

@end
