//
//  UserInfo.h
//  angelslike
//
//  Created by angelslike on 15/8/11.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject

+(UserInfo *)shared;


@property(nonatomic,strong) NSString *uid;
@property(nonatomic,strong) NSMutableDictionary *info;//用户信息
@property(nonatomic) BOOL loadGuide;//是否载入引导页
@property(nonatomic,strong) NSDictionary *wxInfo;

@end
