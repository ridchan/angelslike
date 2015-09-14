//
//  CouRecrodCell.h
//  angelslike
//
//  Created by angelslike on 15/9/7.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeaderDefiner.h"
#import "ReplayView.h"

typedef enum{
    CouCellType_Comment = 1001,
    CouCellType_Praise = 2001,
    CouCellType_More = 3001,
}CouCellType;

@interface CouRecrodCell : UITableViewCell{
    UIView *backView;
    UIImageView *imageView;
    UILabel *nameLabel;
    UILabel *dateLabel;
    UILabel *commentLabel;
    
    UILabel *qtylabel;
    UILabel *pricelabel;
    
    ReplayView *r1;
    ReplayView *r2;
    
    id tar;
    SEL act;
    
    
    UILabel *pariseLbl;
    UILabel *reviewLbl;
    
    UIButton *button;
}

@property(nonatomic,strong) NSDictionary *info;

-(void)addTarget:(id)target action:(SEL)action;

@end
