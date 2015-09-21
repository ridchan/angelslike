//
//  AliPayObj.m
//  angelslike
//
//  Created by angelslike on 15/9/18.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import "AliPayObj.h"

@implementation AliPayObj

+(void)payWithInfo:(NSDictionary *)info successBlock:(AlipayBlock)sblock failBlock:(AlipayBlock)fblock{
    NSMutableString *privateKey = [NSMutableString string];
    [privateKey appendString:@"MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBAK6PtuuJiEWczsOI\n"];
    [privateKey appendString:@"X4J1plCApFUqgV5sJfSatHakdO+o0CX/ufM7qHOdp0sLL8Y+DAjNMzJBSqmKgtkB\n"];
    [privateKey appendString:@"Iz3Ow9JqmfUi4VwhLolYzdiSqhuwSPE8VUYDZvjBP0tNpsbSaFX/Gvn8Qmqz5R0v\n"];
    [privateKey appendString:@"oIsIfNtt1wnd3uXPExW5E/IMpqYjAgMBAAECgYEAoaP2kBiklUFkvO808csbnIPi\n"];
    [privateKey appendString:@"p/JaJSMj6mKvJQWYOqwpQmaQu8jMbXLZDMZpELs3zZamB60qA+B81ZEWHw+th0wH\n"];
    [privateKey appendString:@"K4PfaBq2clFm0IIK1YbH7aFbirrn7gwU6y0u/12aUxWAnuSs3oshKiLFP0cZFEYn\n"];
    [privateKey appendString:@"kWM90ZAj1dOkrA3u2nECQQDkJlcu4hcYCjfyb8Jc2mhi+rJyWXVtOrG8vGgbf+Hf\n"];
    [privateKey appendString:@"Y0UJJgoGyuAQD/C4VYQYLBympUoCwVimrQrBg05l/Dm9AkEAw9697KlfvOdqkVTs\n"];
    [privateKey appendString:@"uPTzdSNvUiZaZqmCpBUK5BW27HLi2HZ1YeyH0Emuenwc1LmviTFDFGE8rbzKeChe\n"];
    [privateKey appendString:@"hnMtXwJAHiTesggXSwrWl4aipIgK8MD04NznAfaWUzyFeNStsEk6btoCyyD098pT\n"];
    [privateKey appendString:@"YNeTq2nwoygFnlWTc/o7CJRjwF/R9QJAfv4cz6NlIjo8Wuvf629NpeYKmA2r0SIY\n"];
    [privateKey appendString:@"RMAr5oO5rQYz07rCEnJkAAS1rk5n9vhJOj8JSd5dlBtyfoNV/gARKwJAc6eBXPNA\n"];
    [privateKey appendString:@"HC5gLOIZNfqW7/sXhjZR47W3AdQsoKQekmVfHsh6ixq4vKn3TJtC8rbwTNknRLs4\n"];
    [privateKey appendString:@"ti1V2itso6belw==\n"];
    
    
    
    //生成订单信息及签名
    
    //将商品信息赋予AlixPayOrder的成员变量
    Order *order = [[Order alloc] init];
    order.partner = AliPID;
    order.seller = AliSID;
    order.tradeNO = [info strForKey:@"orderno"]; //订单ID（由商家自行制定）
    order.productName = @"天使礼客"; //商品标题
    order.productDescription = @"天使礼客"; //商品描述
    order.amount = [NSString stringWithFormat:@"%.2f",[info floatForKey:@"amount"]]; //商品价格
    order.notifyURL =  @"http://app.angelslike.com/notify/index"; //回调URL
    
    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m";
    order.showUrl = @"m.alipay.com";
    
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = @"angelslike";
    
    //将商品信息拼接成字符串
    NSString *orderSpec = [order description];
    NSLog(@"orderSpec = %@",orderSpec);
    
    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner(privateKey);
    NSString *signedString = [signer signString:orderSpec];
    
    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = nil;
    if (signedString != nil) {
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                       orderSpec, signedString, @"RSA"];
        
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            if ([resultDic intForKey:@"resultStatus"] == 9000) {
                if (sblock) sblock(resultDic);
            }else{
                if (fblock) fblock(resultDic);
                //
            }
        }];
        
    }

}

@end
