//
//  CommentCell.h
//  angelslike
//
//  Created by angelslike on 15/8/25.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeaderDefiner.h"
#import "ReplayView.h"

typedef enum{
    CommentCellType_Comment = 1001,
    CommentCellType_Praise = 2001,
    CommentCellType_ShowMore = 3001,
}CommentCellType;

@interface CommentCell : UITableViewCell{
    UIView *backView;
    UIImageView *imageView;
    UILabel *nameLabel;
    UILabel *dateLabel;
    UILabel *commentLabel;
    
    UILabel *pariseLbl;
    UILabel *reviewLbl;
    
    ReplayView *r1;
    ReplayView *r2;
    
    id tar;
    SEL act;
    
    UIButton *button;
}

@property(nonatomic,strong) NSDictionary *info;

-(void)addTarget:(id)target action:(SEL)action;

@end
