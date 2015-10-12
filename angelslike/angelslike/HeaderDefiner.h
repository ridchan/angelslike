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
#define isIOS8 [[[UIDevice currentDevice] systemVersion] floatValue] >=8.0
#define isiPhone4 ([UIScreen mainScreen].bounds.size.height == 480)
#define FontWS(s) [UIFont systemFontOfSize:s]
#define BFontWS(s) [UIFont boldSystemFontOfSize:s]
#define RGBA(r,g,b,a) [UIColor colorWithRed:(float)(r/255.0f)green:(float)(g / 255.0f) blue:(float)(b / 255.0f)alpha:a]
#define HexColor(hex) [UIColor getHexColor:hex]
#define HEXCOLOR(c)   [UIColor colorWithRed:((c>>16)&0xFF)/255.0f green:((c>>8)&0xFF)/255.0f blue:(c&0xFF)/255.0f alpha:1.0f];

//web文本来源地址，用于取图
#define MainUrl @"http://www.angelslike.com"
//主域名
#define MainDomain @"http://app.angelslike.com/"
//图片地址
#define img1Url @"http://img1.angelslike.com"
#define img2Url @"http://img2.angelslike.com"
#define img3Url @"http://img3.angelslike.com"
//广告栏
#define SliderLink @"http://www.angelslike.com/json/getslider"
//我的凑分子
#define MyCouUrl [MainDomain stringByAppendingPathComponent:@"my/mycourecords"]
#define CouRecordUrl [MainDomain stringByAppendingPathComponent:@"cou/records"]
#define CouUrl [MainDomain stringByAppendingPathComponent:@"cou/lists"]
#define CouDetailUrl [MainDomain stringByAppendingPathComponent:@"cou/detail"]
#define MyOrderUrl [MainDomain stringByAppendingPathComponent:@"my/myorder"]
#define ComfirmCouUrl [MainDomain stringByAppendingPathComponent:@"cou/confirmcou"]
#define CouPayUrl  [MainDomain stringByAppendingPathComponent:@"cou/couinfopay"] //http://app.angelslike.com/cou/couinfopay
//主题
#define ListLink [MainDomain stringByAppendingPathComponent:@"theme/lists"]
#define ThemeUrl [MainDomain stringByAppendingPathComponent:@"theme/detail"]
//登陆
#define LoginUrl [MainDomain stringByAppendingPathComponent:@"index/login"]
#define AppLoginUrl [MainDomain stringByAppendingPathComponent:@"index/login"] //微信登陆接口 unionid
//注册
#define RegistUrl [MainDomain stringByAppendingPathComponent:@"index/register"]
//产品列表
#define ProductsUrl [MainDomain stringByAppendingPathComponent:@"product/lists"]
#define ProductUrl [MainDomain stringByAppendingPathComponent:@"product/detail"]
#define ProductBuyRecordUrl [MainDomain stringByAppendingPathComponent:@"product/buyrecords"]
#define ProductCouRecordUrl [MainDomain stringByAppendingPathComponent:@"product/courecords"]
//评论
#define CommentsUrl [MainDomain stringByAppendingPathComponent:@"review/lists"]
#define CommentAddUrl [MainDomain stringByAppendingPathComponent:@"review/add"]
//点赞
#define PraiseUrl [MainDomain stringByAppendingPathComponent:@"json/praise"]
//收藏
#define CollectUrl [MainDomain stringByAppendingPathComponent:@"json/collect"]
//我的钱包
#define MyWallentUrl [MainDomain stringByAppendingPathComponent:@"my/mywallet"]

//支付记录
#define MyPayRecordUrl [MainDomain stringByAppendingPathComponent:@"my/mypayrecords"]

//立即购买
#define BuyNowUrl [MainDomain stringByAppendingPathComponent:@"buynow"]
//取消订单
#define CancelOrderUrl [MainDomain stringByAppendingPathComponent:@"index/cancelOrder"]
//取消凑分子
#define CancelCouUrl [MainDomain stringByAppendingPathComponent:@"index/cancelOrder"]
//获取地址
#define AddressUrl [MainDomain stringByAppendingPathComponent:@"index/getaddress"]

//保税仓，买一送一
#define MPUrl [MainDomain stringByAppendingPathComponent:@"json/getList"]
//买一送一明细
#define BuyOneDetail [MainDomain stringByAppendingPathComponent:@"json/special"]
#define BuyingUrl [MainDomain stringByAppendingPathComponent:@"json/buyinglist"]
#define SetGiftUrl [MainDomain stringByAppendingPathComponent:@"json/setgiftkey"]


#define SaveImageUrl @"http://weixin.angelslike.com/json/saveimage"

//主题 路径

//订单详情
#define OrderDetailUrl [MainDomain stringByAppendingPathComponent:@"my/getorder"]

#define MyInfoUrl [MainDomain stringByAppendingPathComponent:@"my/myinfo"]
#define UpdateMyInfoUrl [MainDomain stringByAppendingPathComponent:@"my/updatemyinfo"]

//分享
#define ThemeShareUrl @"http://weixin.angelslike.com/theme.html?id="
#define ProductShareUrl @"http://weixin.angelslike.com/product.html?id="
#define GiftUrl @"http://weixin.angelslike.com/yougift.html?k="

#define AliPID @"2088911709405062"
#define AliSID @"2868362748@qq.com"

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

#define MoneySign @"￥"

#import "NSDictionary_IngoreNull.h"
#import "RCRoundButton.h"
#import "UserInfo.h"
#import "UIColor+HexColor.h"
#import "UIImage+RTTint.h"
#import "UIImageView+PreUrl.h"
#import "UILabel+Resize.h"
#import "UIView+Controller.h"

#import "RCWebView.h"
#import "RCButton.h"

#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

//#define SuppressPerformSelectorLeakWarning(Stuff) \
//
//do { \
//    
//    _Pragma("clang diagnostic push") \
//    
//    _Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
//    
//    Stuff; \
//    
//    _Pragma("clang diagnostic pop") \
//    
//} while (0)

//设置View的tag属性
#define VIEWWITHTAG(_OBJECT, _TAG)    [_OBJECT viewWithTag : _TAG]


#define RECT(x,y,w,h) CGRectMake(x,y,w,h)
#define Format2(a,b) [NSString stringWithFormat:@"%@%@",a,b]
#define Format3(a,b,c) [NSString stringWithFormat:@"%@%@%@",a,b,c]
#define IMAGE(n) [UIImage imageNamed:n]
#define UserDefault [NSUserDefaults standardUserDefaults]

#define MaxY(a) CGRectGetMaxY(a.frame)
#define MaxX(a) CGRectGetMaxX(a.frame)

#define ResizeHeight(a,h) CGRectMake(a.frame.origin.x, a.frame.origin.y, a.frame.size.width, h)
#define ResizeWidth(a,w) CGRectMake(a.frame.origin.x, a.frame.origin.y, w, a.frame.size.height)
#define ResizeY(a,y) CGRectMake(a.frame.origin.x, y, a.frame.size.width, a.frame.size.height)

#endif//
