//
//  WeiXinPayObj.h
//  angelslike
//
//  Created by angelslike on 15/9/18.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetWork.h"
#import "WXApi.h"
#import <CommonCrypto/CommonDigest.h>


#define GetOrderInfo @"http://weixin.angelslike.com/json/app_weixin_pay"

#define APP_ID          @"" //APPID
#define APP_SECRET      @"" //appsecret
//商户号，填写商户对应参数
#define MCH_ID          @"tianshilike665445699013719146990"
//商户API密钥，填写相应参数
#define PARTNER_ID      @"1263950201"
//支付结果回调页面
#define NOTIFY_URL      @"http://wxpay.weixin.qq.com/pub_v2/pay/notify.v2.php"
//获取服务器端支付数据地址（商户自定义）
#define SP_URL          @"http://wxpay.weixin.qq.com/pub_v2/app/app_pay.php"

/*
 XML 解析库api说明：
 //============================================================================
 
 //输入参数为xml格式串，初始化解析器
 -(void)startParse:(NSData *)data;
 
 //获取解析后的字典
 -(NSMutableDictionary*) getDict;
 
 //============================================================================
 */
@interface XMLHelper : NSObject<NSXMLParserDelegate> {
    
    //解析器
    NSXMLParser *xmlParser;
    //解析元素
    NSMutableArray *xmlElements;
    //解析结果
    NSMutableDictionary *dictionary;
    //临时串变量
    NSMutableString *contentString;
}
//输入参数为xml格式串，初始化解析器
-(void)startParse:(NSData *)data;
//获取解析后的字典
-(NSMutableDictionary*) getDict;
@end


@interface WXUtil :NSObject <NSXMLParserDelegate>
{
}
/*
 加密实现MD5和SHA1
 */
+(NSString *) md5:(NSString *)str;
+(NSString*) sha1:(NSString *)str;
/**
 实现http GET/POST 解析返回的json数据
 */
+(NSData *) httpSend:(NSString *)url method:(NSString *)method data:(NSString *)data;
@end

@interface payRequsestHandler : NSObject{
    //预支付网关url地址
    NSString *payUrl;
    
    //lash_errcode;
    long     last_errcode;
    //debug信息
    NSMutableString *debugInfo;
    NSString *appid,*mchid,*spkey;
}
//初始化函数
-(BOOL) init:(NSString *)app_id mch_id:(NSString *)mch_id;
-(NSString *) getDebugifo;
-(long) getLasterrCode;
//设置商户密钥
-(void) setKey:(NSString *)key;
//创建package签名
-(NSString*) createMd5Sign:(NSMutableDictionary*)dict;
//获取package带参数的签名包
-(NSString *)genPackage:(NSMutableDictionary*)packageParams;
//提交预支付
-(NSString *)sendPrepay:(NSMutableDictionary *)prePayParams;
//签名实例测试
- ( NSMutableDictionary *)sendPay_demo;

@end


@interface WeiXinPayObj : NSObject

+(NSDictionary *)GetOrderInfoFromID:(NSString *)strID;

@end
