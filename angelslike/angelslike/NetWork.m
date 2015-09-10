//
//  NetWork.m
//  angelslike
//
//  Created by angelslike on 15/8/4.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import "NetWork.h"



@implementation NetWork

+(instancetype)shared{
    static NetWork *shareInstance = nil ;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        shareInstance = [[NetWork alloc]init];
    });
    
    return shareInstance;
}

-(NSOperationQueue *)GetQueue{
    return queue;
}

-(instancetype)init{
    self = [super init];
    queue = [[NSOperationQueue alloc]init];
    return self;
}

-(void)query:(NSString *)link info:(NSDictionary *)info block:(NetWorkBlock)block lock:(BOOL)lock{
    NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:link]];
    NSMutableString *postString = [NSMutableString string];
    if (info!=nil) {
        for (NSString *key in [info allKeys]) {
            [postString appendFormat:@"&%@=%@",key,[info objectForKey:key]];
        }
        
    }
    NSData *postdata = [postString dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    NSString *postlength = [NSString stringWithFormat:@"%lu",(unsigned long)[postdata length]];
    [request setValue:postlength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:postdata];
    
    [[BaiduMobStat defaultStat] webviewStartLoadWithRequest:request];
    [self currentThreadAdding];
    if (lock) [RCHub show];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSError *error;
            if (lock) [RCHub dismiss];
            if (data == nil)
                block(nil);
            else
                block([NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error]);
            [self currentThreadReducing];
        });
        
        
    }];
}


-(void)currentThreadAdding{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    self.currentThreads ++ ;
}

-(void)currentThreadReducing{
    self.currentThreads -- ;
    if (self.currentThreads <= 0) {
        self.currentThreads = 0;
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    }
}

-(void)startQuery:(NSString *)link info:(NSDictionary *)info completeBlock:(NetWorkBlock)block{
    NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:link]];
    NSMutableString *postString = [NSMutableString string];
    if (info!=nil) {
        for (NSString *key in [info allKeys]) {
            [postString appendFormat:@"&%@=%@",key,[info objectForKey:key]];
        }
        
    }
    NSData *postdata = [postString dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    NSString *postlength = [NSString stringWithFormat:@"%lu",(unsigned long)[postdata length]];
    [request setValue:postlength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:postdata];
    
    [[BaiduMobStat defaultStat] webviewStartLoadWithRequest:request];
    [self currentThreadAdding];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSError *error;
            if (data == nil) 
                block(nil);
            else
                block([NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error]);
            
            [self currentThreadReducing];

        });
        
        
    }];
}

@end
