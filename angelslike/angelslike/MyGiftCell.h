//
//  MyGiftCell.h
//  angelslike
//
//  Created by angelslike on 15/10/10.
//  Copyright © 2015年 angelslike. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeaderDefiner.h"

typedef enum{
    CellActionType_Left = 1001,
    CellActionType_Right = 1002
} CellActionType;

@interface MyGiftCell : UITableViewCell{
    UILabel *dateLbl;
    UIImageView *productImg;
    UILabel *nameLbl;
    UILabel *priceLbl;
    UIImageView *peopleImg;
    UILabel *peopleLbl;
    UILabel *label;
    id tar;
    SEL act;
}


-(void)addTarget:(id)target action:(SEL)action;
@property(nonatomic,strong) NSDictionary *info;
@property(nonatomic) NSInteger type;
@property(nonatomic) BOOL isLeft;

@end
