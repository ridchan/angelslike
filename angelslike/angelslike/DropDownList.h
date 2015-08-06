//
//  DropDownList.h
//  angelslike
//
//  Created by angelslike on 15/8/6.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeaderDefiner.h"

@interface ListItem : NSObject

@property(nonatomic,strong) NSString *name;
@property(nonatomic,strong) NSString *value;

@end

@interface DropDownList : UIView<UITableViewDelegate,UITableViewDataSource>{
    id tar;
    SEL act;
}

@property(nonatomic,strong) NSArray *titles;
@property(nonatomic,strong) NSArray *listItems;

-(void)addTarget:(id)target action:(SEL)action;

@end
