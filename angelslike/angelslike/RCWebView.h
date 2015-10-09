//
//  RCWebView.h
//  angelslike
//
//  Created by angelslike on 15/10/9.
//  Copyright © 2015年 angelslike. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeaderDefiner.h"

typedef void(^WebViewBlock)(id obj);

@interface RCWebView : UIWebView<UIWebViewDelegate>

@property(nonatomic,copy) WebViewBlock block;

-(void)setText:(NSString *)text;

@end
