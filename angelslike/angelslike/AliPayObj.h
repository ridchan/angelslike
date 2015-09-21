//
//  AliPayObj.h
//  angelslike
//
//  Created by angelslike on 15/9/18.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AlipaySDK/AlipaySDK.h>
#import "HeaderDefiner.h"
#import "Order.h"
#import "DataSigner.h"
#import "APAuthV2Info.h"
#import <AlipaySDK/AlipaySDK.h>

typedef void(^AlipayBlock)(id obj);


@interface AliPayObj : NSObject

+(void)payWithInfo:(NSDictionary *)info successBlock:(AlipayBlock)sblock failBlock:(AlipayBlock)fblock;

@end
