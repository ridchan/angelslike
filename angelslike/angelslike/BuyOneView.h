//
//  BuyOneView.h
//  angelslike
//
//  Created by angelslike on 15/9/24.
//  Copyright © 2015年 angelslike. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeaderDefiner.h"

@interface BuyOneView : UIView{
    UIImageView *imageView;
    UILabel *nameLbl;
    UILabel *priceLbl;
    UILabel *lbl1;
    UILabel *lbl2;
    UILabel *disLbl;
    UILabel *stockLbl;
}



@property(nonatomic,strong) NSDictionary *info;

@end
