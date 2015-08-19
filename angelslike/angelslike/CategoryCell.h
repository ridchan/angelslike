//
//  CategoryCell.h
//  angelslike
//
//  Created by angelslike on 15/8/6.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeaderDefiner.h"


@protocol CategoryCellDelegate <NSObject>

-(void)cellClick:(NSDictionary *)info;

@end

@interface CellItem : UIView{
    UIImageView *imageView;
    UILabel *label;
}

@property(nonatomic,strong) NSDictionary *info;

@end

@interface CategoryCell : UITableViewCell{
    UILabel *titleLabel;
    UIScrollView *_scrollView;
}

@property(nonatomic) id<CategoryCellDelegate>delegate;
@property(nonatomic,strong) NSArray *buttonInfos;
@property(nonatomic,strong) NSString *title;



@end
