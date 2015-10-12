//
//  GiftSendViewController.h
//  angelslike
//
//  Created by angelslike on 15/10/12.
//  Copyright © 2015年 angelslike. All rights reserved.
//

#import "BaseViewController.h"

@interface GiftSendViewController : BaseViewController{
    __block UIImageView *tempCover ;
    UIScrollView *_scrollView;
    UITextView *textView;
}

@property(nonatomic,strong) NSDictionary *info;

@end
