//
//  WebViewController.h
//  angelslike
//
//  Created by angelslike on 15/8/25.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import "BaseViewController.h"

@interface WebViewController : BaseViewController<UIScrollViewDelegate>{
    UIScrollView *scView;
}

@property(nonatomic,strong) NSString *content;
@property(nonatomic,strong) NSString *baseUrl;

@end
