//
//  DealView.h
//  angelslike
//
//  Created by angelslike on 15/9/24.
//  Copyright © 2015年 angelslike. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeaderDefiner.h"

typedef enum {
    CellType_Deal,
    CellType_BuyOne,
    CellType_Bound,
}CellType;

@interface DealView : UIView{
    UIImageView *logo;
    UIImageView *imageView;
    UILabel *nameLbl;
    UILabel *priceLbl;
    UILabel *lbl1;
    UILabel *lbl2;
    UILabel *disLbl;
    UILabel *stockLbl;
}

@property(nonatomic) CellType type;

@property(nonatomic,strong) NSDictionary *info;

@end
