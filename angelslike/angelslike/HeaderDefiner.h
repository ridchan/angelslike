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


#define SliderLink @"http://www.angelslike.com/json/getslider"
#define ListLink @"http://www.angelslike.com/json/getlist"
#define ImageLink @"http://img1.angelslike.com"
#define LoginUrl @"http://www.angelslike.com/json/login"
#define RegistUrl @"http://www.angelslike.com/json/register"
#define CouDetailUrl @"http://www.angelslike.com/items.html"
#define AppLoginUrl @"http://www.angelslike.com/json/applogin" //微信登陆接口 unionid

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
#import "UIImageView+WebCache.h"
#import "UIImage+RTTint.h"

#pragma clang diagnostic ignored "-Warc-performSelector-leaks"




#endif//
