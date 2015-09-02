//
//  WebViewController.h
//  angelslike
//
//  Created by angelslike on 15/8/25.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import "BaseViewController.h"

@interface WebViewController : BaseViewController<UIScrollViewDelegate,UIWebViewDelegate>{
    UIScrollView *scView;
    BOOL canMove;
}

@property(nonatomic,strong) NSString *content;
@property(nonatomic,strong) NSString *baseUrl;

@end
