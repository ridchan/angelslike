//
//  UserInfo.m
//  angelslike
//
//  Created by angelslike on 15/8/11.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import "UserInfo.h"

@implementation UserInfo

@synthesize info = _info;

+(UserInfo *)shared{
    static UserInfo *shareInstance = nil ;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        shareInstance = [[UserInfo alloc]init];
    });
    
    return shareInstance;
}

-(void)setInfo:(UserInfo *)info{
    _info = [info mutableCopy];
    if (_info) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:_info options:NSJSONWritingPrettyPrinted error:nil];
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"UserInfo"];
    }
}

-(UserInfo *)info{
//    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"UserInfo"]) {
//        NSData *data = [[NSUserDefaults standardUserDefaults]objectForKey:@"UserInfo"];
//        return [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
//    }
    return nil;
}


-(BOOL)loadGuide{
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    
    NSString  *lastVersion = nil;
    if ([def stringForKey:@"Version"])
        lastVersion = [def stringForKey:@"Version"];
    
    // app版本
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    [def setObject:app_Version forKey:@"Version"];
    
    return YES;// ![lastVersion isEqualToString:app_Version];
//    float curVersion = [ap]
    
}

@end