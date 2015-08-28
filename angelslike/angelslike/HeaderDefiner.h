//
//  HeaderDefiner.h
//  angelslike
//
//  Created by angelslike on 15/8/4.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#ifndef angelslike_HeaderDefiner_h


#define angelslike_HeaderDefiner_h

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define FontWS(s) [UIFont systemFontOfSize:s]
#define RGBA(r,g,b,a) [UIColor colorWithRed:(float)(r/255.0f)green:(float)(g / 255.0f) blue:(float)(b / 255.0f)alpha:a]

#define MyCouUrl @"http://app.angelslike.com/my/mycourecords"

#define SliderLink @"http://www.angelslike.com/json/getslider"
#define ListLink @"http://www.angelslike.com/json/getlist"
#define ImageLink @"http://img1.angelslike.com"
#define LoginUrl @"http://app.angelslike.com/index/login"
#define RegistUrl @"http://www.angelslike.com/json/register"
#define CouDetailUrl @"http://app.angelslike.com/cou/detail"
#define AppLoginUrl @"http://app.angelslike.com/index/login" //微信登陆接口 unionid
#define ProductsUrl @"http://app.angelslike.com/product/lists"
#define ProductUrl @"http://app.angelslike.com/product/detail"
#define CommentsUrl @"http://app.angelslike.com/review/lists"
#define ThemeUrl @"http://app.angelslike.com/theme/detail"

#define BuyNowUrl @"http://app.angelslike.com/buynow"
#define AddressUrl @"http://app.angelslike.com/index/getaddress"

#define MainUrl @"http://www.angelslike.com"

// margin 首页
#define MainCellMargin 10
#define MainCellGap 15
// margin 凑分子
#define CouCellMargin 0
#define CouCellGap 10
#define CouCellHeight 115

// margin 分类
#define CatCellMargin 0
#define CatCellGap 10
#define CatCellHeight 115

#import "NSDictionary_IngoreNull.h"
#import "RCRoundButton.h"
#import "UserInfo.h"
#import "UIColor+HexColor.h"
#import "UIImage+RTTint.h"
#import "UIImageView+PreUrl.h"
#import "UILabel+Resize.h"

#pragma clang diagnostic ignored "-Warc-performSelector-leaks"




#endif//
