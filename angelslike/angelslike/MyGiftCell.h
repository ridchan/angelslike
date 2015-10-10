//
//  MyGiftCell.h
//  angelslike
//
//  Created by angelslike on 15/10/10.
//  Copyright © 2015年 angelslike. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeaderDefiner.h"

@interface MyGiftCell : UITableViewCell{
    UILabel *dateLbl;
    UIImageView *productImg;
    UILabel *nameLbl;
    UILabel *priceLbl;
    UIImageView *peopleImg;
    UILabel *peopleLbl;
}


@property(nonatomic,strong) NSDictionary *info;

@end
