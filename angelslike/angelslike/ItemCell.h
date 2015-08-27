//
//  ItemCell.h
//  angelslike
//
//  Created by angelslike on 15/8/27.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeaderDefiner.h"

@protocol ItemCellDelegate <NSObject>

-(void)checkButtonClick:(id)sender;

@end

@interface ItemCell : UITableViewCell{
    UILabel *nameLabel;
    UILabel *contentLabel;
    UIImageView *imageView;
    UILabel *priceLabel;
    CALayer *line ;
    RCRoundButton *viewButton;
    
}

@property(nonatomic) id<ItemCellDelegate> delegate;
@property(nonatomic,strong) NSDictionary *info;

@end
