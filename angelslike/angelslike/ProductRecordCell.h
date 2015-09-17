//
//  ProductRecordCell.h
//  angelslike
//
//  Created by angelslike on 15/9/17.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeaderDefiner.h"

@interface ProductRecordCell : UITableViewCell{
    UIImageView *imageView;
    UILabel *nameLbl;
    UILabel *timeLbl;
}

@property(nonatomic,retain) NSDictionary *info;


@end
